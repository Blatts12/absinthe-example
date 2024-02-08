defmodule AppWeb.GraphQl.Blog.PostMutations do
  use AppWeb.GraphQl.Schema.Type

  alias AppWeb.GraphQl.Blog.PostResolvers

  object :post_mutations do
    payload field :create_post do
      middleware Authenticated

      input do
        field :title, non_null(:string)
        field :image, :upload
      end

      output do
        field :post, non_null(:post)
      end

      resolve &PostResolvers.create_post/2
    end
  end
end
