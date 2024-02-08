defmodule AppWeb.GraphQl.Types do
  use AppWeb.GraphQl.Schema.Type

  # Accounts
  import_types AppWeb.GraphQl.Accounts.UserTypes

  # Blog
  import_types AppWeb.GraphQl.Blog.PostTypes
end
