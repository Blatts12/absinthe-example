defmodule ExAbsWeb.GraphQl.Accounts.UserQueries do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbs.Accounts
  alias ExAbsWeb.GraphQl.Accounts.UserResolvers

  object :user_queries do
    field :current_user, non_null(:user) do
      middleware Authenticated

      resolve &UserResolvers.current_user/2
    end

    field :get_user, non_null(:user) do
      arg :id, non_null(:id)

      middleware ParseIDs, id: :user
      middleware LoadResource, getter: &Accounts.get_user!/1
      middleware AuthorizeResource

      resolve &UserResolvers.get_user/2
    end
  end
end
