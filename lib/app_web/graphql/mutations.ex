defmodule AppWeb.GraphQl.Mutations do
  use Absinthe.Schema.Notation

  # Blog
  import_types AppWeb.GraphQl.Blog.PostMutations
end
