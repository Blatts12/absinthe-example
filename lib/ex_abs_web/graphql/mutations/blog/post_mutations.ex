defmodule ExAbsWeb.GraphQl.Blog.PostMutations do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbsWeb.GraphQl.Blog.PostResolvers

  object :post_mutations do
    payload field :create_post do
      input do
        field :title, non_null(:string)
        field :user_id, non_null(:id)
      end

      output do
        field :post, non_null(:post)
      end

      middleware ParseIDs, input: [user_id: :user]

      resolve &PostResolvers.create_post/2
    end
  end
end
