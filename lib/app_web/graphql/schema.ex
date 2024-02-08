defmodule AppWeb.GraphQl.Schema do
  use Absinthe.Schema

  # datetime, native_datetime, decimal
  import_types Absinthe.Type.Custom

  import_types AppWeb.GraphQl.Mutations
  import_types AppWeb.GraphQl.Queries
  import_types AppWeb.GraphQl.Types

  query do
    # Accounts
    import_fields :user_queries

    # Blog
    import_fields :post_queries
  end

  mutation do
    # Blog
    import_fields :post_mutations
  end

  # subscription do
  # end
end
