defmodule AppWeb.GraphQl.Blog.PostMutations do
  use AppWeb.GraphQl.Schema.Type

  alias AppWeb.GraphQl.Blog.PostResolvers

  object :post_mutations do
    field :create_post, non_null(:post) do
      arg :input, non_null(:create_post_input)

      resolve &PostResolvers.create_post/2
    end
  end
end
