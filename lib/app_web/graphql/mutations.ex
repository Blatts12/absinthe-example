defmodule AppWeb.GraphQl.Mutations do
  use Absinthe.Schema.Notation

  # Accounts
  import_types AppWeb.GraphQl.Accounts.UserTokenMutations

  # Blog
  import_types AppWeb.GraphQl.Blog.PostMutations
end
