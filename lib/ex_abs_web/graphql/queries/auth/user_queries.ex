defmodule ExAbsWeb.GraphQl.Auth.UserQueries do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias ExAbsWeb.GraphQl.Auth.UserResolvers

  object :user_queries do
    field :get_user, :user do
      arg :id, non_null(:id)

      resolve &UserResolvers.get_user/2
    end

    field :list_users, list_of(:user) do
      resolve &UserResolvers.list_users/2
    end
  end
end
