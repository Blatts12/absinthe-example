defmodule AppWeb.UserSocket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: AppWeb.GraphQl.Schema

  alias App.Accounts
  alias App.Accounts.User

  @impl true
  def connect(params, socket, _connect_info) do
    params = Map.new(params, fn {k, v} -> {String.downcase(k), v} end)

    socket =
      if current_user = current_user(params) do
        socket
        |> assign(:current_user, current_user)
        |> Absinthe.Phoenix.Socket.put_options(context: %{current_user: current_user})
      end

    {:ok, socket}
  end

  defp current_user(%{"authorization" => "Bearer " <> token}) do
    with %User{} = user <- Accounts.get_user(token) do
      user
    end
  end

  defp current_user(_), do: nil

  @impl true
  def id(%Phoenix.Socket{assigns: %{current_user: %{id: id}}}), do: "user:#{id}"
  def id(_socket), do: nil
end
