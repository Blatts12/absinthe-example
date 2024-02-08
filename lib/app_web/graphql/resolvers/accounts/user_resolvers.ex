defmodule AppWeb.GraphQl.Accounts.UserResolvers do
  import Ecto.Query

  alias App.Accounts
  alias App.Accounts.User
  alias App.Repo

  def get_user(%{id: id}, _resolution) do
    case Accounts.get_user(id) do
      %User{} = user -> {:ok, user}
      _ -> {:error, :not_found}
    end
  end

  def get_user(%{user_id: user_id}, _args, _resolution) do
    {:ok, Accounts.get_user(user_id)}
  end

  def list_users_by_ids(_model, user_ids) do
    users = Repo.all(from u in User, where: u.id in ^user_ids)
    Map.new(users, fn user -> {user.id, user} end)
  end

  def current_user(_args, %{context: %{current_user: user}}) do
    {:ok, user}
  end
end
