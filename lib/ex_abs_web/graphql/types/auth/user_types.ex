defmodule ExAbsWeb.GraphQl.Auth.UserTypes do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbs.Blog.Post

  object :user do
    field :id, non_null(:id)
    field :username, :string
    field :posts, non_null(list_of(non_null(:post))), resolve: dataloader(Post)
  end

  object :user_pagination do
    field :entries, list_of(:user)
    field :metadata, :pagination_metadata
  end

  input_object :create_user_input do
    field :username, non_null(:string)
  end
end
