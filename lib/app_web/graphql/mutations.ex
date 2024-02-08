defmodule AppWeb.GraphQl.Mutations do
  use AppWeb.GraphQl.Schema.Type

  # Blog
  import_types AppWeb.GraphQl.Blog.PostMutations
end
