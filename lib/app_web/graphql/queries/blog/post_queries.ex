defmodule AppWeb.GraphQl.Blog.PostQueries do
  use AppWeb.GraphQl.Schema.Type

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

    connection field :paginate_posts, node_type: :post do
      resolve &PostResolvers.paginate_posts/2
    end
  end
end
