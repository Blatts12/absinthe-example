defmodule AppWeb.GraphQl.Accounts.UserQueries do
  use AppWeb.GraphQl.Schema.Type

  alias AppWeb.GraphQl.Accounts.UserResolvers

  object :user_queries do
    field :get_user, non_null(:user) do
      arg :id, non_null(:id)
      resolve &UserResolvers.get_user/2
    end
  end
end
