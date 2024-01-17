defmodule ExAbsWeb.GraphQl.Blog.PostMutations do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbsWeb.GraphQl.Blog.PostResolvers

  object :post_mutations do
    payload field :create_post do
      input do
        field :title, non_null(:string)
      end

      output do
        field :post, non_null(:post)
      end

      resolve &PostResolvers.create_post/2
    end
  end
end
