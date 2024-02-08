defmodule AppWeb.GraphQl.Subscriptions do
  use Absinthe.Schema.Notation

  # Blog
  import_types AppWeb.GraphQl.Blog.PostSubscriptions
end
