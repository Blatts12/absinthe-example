defmodule ExAbsWeb.GraphQl.Blog.PostMutations do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbsWeb.GraphQl.Blog.PostResolvers

  object :post_mutations do
    field :create_post, type: :post do
      arg :input, non_null(:create_post_input)

      resolve &PostResolvers.create_post/2
    end
  end
end
