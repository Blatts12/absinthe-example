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

  @spec list_users(map(), map()) :: {:ok, [User.t()]} | {:error, term()}
  def list_users(_args, _resolution) do
    {:ok, Auth.list_users()}
  end

  @spec create_user(map(), map()) :: {:ok, User.t()} | {:error, term()}
  def create_user(%{input: args}, _resolution) do
    with {:ok, %User{} = user} <- Auth.create_user(args) do
      # This is how you publish a subscription event from a resolver
      # Absinthe.Subscription.publish(ExAbsWeb.Endpoint, user, user_created: "user_created")
      #                               ^endpoint          ^payload, ^[subscription_name: "topic"]

      {:ok, user}
    end
  end
end
