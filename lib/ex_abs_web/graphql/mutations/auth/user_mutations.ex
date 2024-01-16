defmodule ExAbsWeb.GraphQl.Auth.UserMutations do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbsWeb.GraphQl.Auth.UserResolvers

  object :user_mutations do
    field :create_user, type: :user do
      arg :input, non_null(:create_user_input)

      resolve &UserResolvers.create_user/2
    end
  end
end
