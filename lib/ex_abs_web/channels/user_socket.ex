defmodule ExAbsWeb.UserSocket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: ExAbsWeb.GraphQl.Schema

  alias ExAbs.Accounts
  alias ExAbs.Accounts.User

  # A Socket handler
  #
  # It's possible to control the websocket connection and
  # assign values that can be accessed by your channel topics.

  ## Channels
  # Uncomment the following line to define a "room:*" topic
  # pointing to the `ExAbsWeb.RoomChannel`:
  #
  # channel "room:*", ExAbsWeb.RoomChannel
  #
  # To create a channel file, use the mix task:
  #
  #     mix phx.gen.channel Room
  #
  # See the [`Channels guide`](https://hexdocs.pm/phoenix/channels.html)
  # for further details.

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error` or `{:error, term}`. To control the
  # response the client receives in that case, [define an error handler in the
  # websocket
  # configuration](https://hexdocs.pm/phoenix/Phoenix.Endpoint.html#socket/3-websocket-configuration).
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(params, socket, _connect_info) do
    params = Map.new(params, fn {k, v} -> {String.downcase(k), v} end)

    socket =
      case get_current_user(params) do
        {token, user} ->
          socket
          |> assign(:current_user, user)
          |> Absinthe.Phoenix.Socket.put_options(context: %{current_user: user, token: token})

        _ ->
          socket
      end

    {:ok, socket}
  end

  @spec get_current_user(Plug.Conn.params()) :: {String.t(), User.t()} | nil
  defp get_current_user(%{"authorization" => "Bearer " <> token}) do
    with %User{} = user <- Accounts.get_user_by_session_token(token) do
      {token, user}
    end
  end

  defp get_current_user(_), do: nil

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Elixir.ExAbsWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(_socket), do: nil
end
