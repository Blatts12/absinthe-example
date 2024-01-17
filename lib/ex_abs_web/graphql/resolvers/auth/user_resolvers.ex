defmodule ExAbsWeb.GraphQl.Auth.UserResolvers do
  @moduledoc false

  alias ExAbs.Auth
  alias ExAbs.Auth.User

  @spec get_user(map(), map()) :: {:ok, User.t()} | {:error, term()}
  def get_user(%{id: id}, _resolution) do
    case Auth.get_user(id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :not_found}
    end
  end

  @spec list_users(map(), map()) :: {:ok, [User.t()]}
  def list_users(_args, _resolution) do
    {:ok, Auth.list_users()}
  end

  @spec paginate_users(map(), map()) :: {:ok, map()} | {:error, any()}
  def paginate_users(args, _resolution) do
    Auth.paginate_users(args)
  end

  @spec create_user(map(), map()) :: {:ok, %{user: User.t()}} | {:error, term()}
  def create_user(args, _resolution) do
    with {:ok, %User{} = user} <- Auth.create_user(args) do
      # This is how you publish a subscription event from a resolver
      # Absinthe.Subscription.publish(ExAbsWeb.Endpoint, user, user_created: "user_created")
      #                               ^endpoint          ^payload, ^[subscription_name: "topic"]

      {:ok, %{user: user}}
    end
  end

  @spec create_user(map(), map()) :: {:ok, User.t()} | {:error, term()}
  def current_user(_args, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def current_user(_args, _resolution) do
    {:error, :unauthorized}
  end
end
