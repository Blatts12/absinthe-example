defmodule AppWeb.GraphQl.Blog.PostMutations do
  use AppWeb.GraphQl.Schema.Type

  alias App.Blog
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

    payload field :update_post do
      middleware Authenticated

      input do
        field :id, non_null(:id)
        field :title, non_null(:string)
      end

      output do
        field :post, non_null(:post)
      end

      middleware ParseIDs, id: :post
      middleware LoadResource, getter: &Blog.get_post!/1
      middleware AuthorizeResource

      resolve &PostResolvers.update_post/2
    end
  end
end
