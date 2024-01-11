defmodule MeloChat.Auth.Users do
  @moduledoc false

  import Ecto.Query, warn: false

  alias MeloChat.Auth.User
  alias MeloChat.Repo
  alias MeloChat.Types

  @spec list_users() :: list(User.t())
  def list_users do
    Repo.all(User)
  end

  @spec get_user!(Types.id()) :: User.t()
  def get_user!(id), do: Repo.get!(User, id)

  @spec get_user(Types.id()) :: User.t() | nil
  def get_user(id), do: Repo.get(User, id)

  @spec create_user(Types.params()) :: Types.ecto_save_result(User.t())
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_user(User.t(), Types.params()) :: Types.ecto_save_result(User.t())
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_user(User.t()) :: Types.ecto_save_result(User.t())
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @spec change_user(User.t(), Types.params()) :: Types.changeset(User.t())
  def change_user(%User{} = user, attrs) do
    User.changeset(user, attrs)
  end
end