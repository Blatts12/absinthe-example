defmodule ExAbsWeb.GraphQl.Auth.UserMutations do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbsWeb.GraphQl.Auth.UserResolvers

  object :user_mutations do
    payload field :create_user do
      input do
        field :username, non_null(:string)
      end

      output do
        field :user, non_null(:user)
      end

      resolve &UserResolvers.create_user/2
    end
  end
end
