defmodule ExAbsWeb.UserSocket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: ExAbsWeb.GraphQl.Schema

  alias ExAbs.Accounts
  alias ExAbs.Accounts.User

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

  @impl true
  def id(%Phoenix.Socket{assigns: %{current_user: %{id: id}}}), do: "user:#{id}"
  def id(_socket), do: nil
end
