defmodule AppWeb.GraphQl.Accounts.UserTokenMutations do
  use AppWeb.GraphQl.Schema.Type

  alias AppWeb.GraphQl.Accounts.UserTokenResolvers

  object :user_token_mutations do
    @desc "Creates a new user"
    payload field :register do
      middleware Unauthenticated

      input do
        field :email, non_null(:string)
        field :password, non_null(:string)
      end

      output do
        field :user, :user
      end

      resolve &UserTokenResolvers.register/2
    end
  end
end
