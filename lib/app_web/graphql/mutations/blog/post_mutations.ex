defmodule AppWeb.GraphQl.Blog.PostMutations do
  use Absinthe.Schema.Notation

  alias AppWeb.GraphQl.Blog.PostResolvers
  alias AppWeb.GraphQl.Middleware.HandleChangesetErrors

  object :post_mutations do
    field :create_post, non_null(:post) do
      arg :input, non_null(:create_post_input)

      resolve &PostResolvers.create_post/2
      middleware HandleChangesetErrors
    end
  end
end
