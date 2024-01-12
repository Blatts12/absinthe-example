defmodule ExAbsWeb.GraphQl.Auth.UserMutations do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias ExAbsWeb.GraphQl.Auth.UserResolvers

  object :user_mutations do
    field :create_user, type: :user do
      arg(:username, non_null(:string))

      resolve(&UserResolvers.create_user/2)
    end
  end
end
