defmodule ExAbsWeb.GraphQl.Accounts.UserTokenMutations do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbsWeb.GraphQl.Accounts.UserTokenResolvers

  object :user_token_mutations do
    @desc "Creates a new user token session"
    payload field :login do
      middleware Unauthenticated

      input do
        field :email, non_null(:string)
        field :password, non_null(:string)
      end

      output do
        field :user_token, :user_token
      end

      resolve &UserTokenResolvers.login_user/2
    end

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

    @desc "Logs out the current user"
    payload field :logout do
      middleware Authenticated

      output do
        field :successful, :boolean
      end

      resolve &UserTokenResolvers.logout/2
    end
  end
end
