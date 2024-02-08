defmodule AppWeb.GraphQl.Queries do
  use Absinthe.Schema.Notation

  # Accounts
  import_types AppWeb.GraphQl.Accounts.UserQueries

  # Blog
  import_types AppWeb.GraphQl.Blog.PostQueries
end
