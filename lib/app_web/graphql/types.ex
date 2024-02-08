defmodule AppWeb.GraphQl.Types do
  use Absinthe.Schema.Notation

  # Accounts
  import_types AppWeb.GraphQl.Accounts.UserTypes

  # Blog
  import_types AppWeb.GraphQl.Blog.PostTypes
end
