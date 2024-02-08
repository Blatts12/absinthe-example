defmodule AppWeb.GraphQl.Subscriptions do
  use AppWeb.GraphQl.Schema.Type

  # Blog
  import_types AppWeb.GraphQl.Blog.PostSubscriptions
end
