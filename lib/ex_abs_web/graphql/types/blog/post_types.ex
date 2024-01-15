defmodule ExAbsWeb.GraphQl.Blog.PostTypes do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias ExAbsWeb.GraphQl.Auth.UserResolvers

  object :post do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :user_id, non_null(:id)

    field :user, non_null(:user) do
      resolve &UserResolvers.get_user/3
    end
  end

  input_object :create_post_input do
    field :title, non_null(:string)
    field :user_id, non_null(:id)
  end
end
