defmodule ExAbsWeb.GraphQl.Auth.UserMutations do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbsWeb.GraphQl.Auth.UserResolvers

  object :user_mutations do
    payload field :create_user do
      input do
        field :username, non_null(:string)
        field :avatar, :upload
      end

      output do
        field :user, non_null(:user)
      end

      resolve &UserResolvers.create_user/2
    end
  end
end

# curl -X POST \
# -F query="mutation { createUser(input: {username: \"username\", avatar: \"image_png\"}) { user { id avatar username }}}" \
# -F image_png=@image.png \
# localhost:4000/api/graphql
