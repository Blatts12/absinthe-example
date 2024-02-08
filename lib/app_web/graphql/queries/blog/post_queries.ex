defmodule AppWeb.GraphQl.Blog.PostQueries do
  use Absinthe.Schema.Notation

  alias AppWeb.GraphQl.Blog.PostResolvers

  object :post_queries do
    field :get_post, non_null(:post) do
      arg :id, non_null(:id)
      resolve &PostResolvers.get_post/2
    end

    field :list_posts, list_of(:post) do
      arg :date, :date
      resolve &PostResolvers.list_posts/3
    end
  end
end
