defmodule ExAbsWeb.GraphQl.Auth.UserTypes do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbs.Blog.Post

  connection(node_type: :user)

  node object(:user) do
    field :username, :string
    field :posts, non_null(list_of(non_null(:post))), resolve: dataloader(Post)
  end
end
