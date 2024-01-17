defmodule ExAbsWeb.GraphQl.Auth.UserQueries do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbsWeb.GraphQl.Auth.UserResolvers

  object :user_queries do
    field :current_user, :user do
      middleware Authenticated

      resolve &UserResolvers.current_user/2
    end

    field :get_user, :user do
      arg :id, non_null(:id)

      middleware ParseIDs, id: :user

      resolve &UserResolvers.get_user/2
    end

    field :list_users, list_of(:user) do
      resolve &UserResolvers.list_users/2
    end

    connection field :paginate_users, node_type: :user do
      resolve &UserResolvers.paginate_users/2
    end
  end
end
