defmodule AppWeb.GraphQl.Queries do
  use AppWeb.GraphQl.Schema.Type

  # Accounts
  import_types AppWeb.GraphQl.Accounts.UserQueries

  # Blog
  import_types AppWeb.GraphQl.Blog.PostQueries
end
