defmodule AppWeb.GraphQl.Blog.PostMutations do
  use Absinthe.Schema.Notation

  object :post_mutations do
    field :create_post, non_null(:post) do
      arg :input, non_null(:create_post_input)

      resolve fn %{input: args}, _ -> App.Blog.create_post(args) end
    end
  end
end
