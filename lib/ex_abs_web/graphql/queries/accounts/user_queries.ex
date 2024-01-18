defmodule ExAbsWeb.GraphQl.Accounts.UserQueries do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbsWeb.GraphQl.Accounts.UserResolvers

  object :user_queries do
    field :current_user, :user do
      middleware Authenticated

      resolve &UserResolvers.current_user/2
    end
  end
end
