defmodule AppWeb.GraphQl.Schema do
  use Absinthe.Schema

  alias AppWeb.GraphQl.Middleware.HandleChangesetErrors

  # datetime, native_datetime, decimal
  import_types Absinthe.Type.Custom

  import_types AppWeb.GraphQl.Mutations
  import_types AppWeb.GraphQl.Subscriptions
  import_types AppWeb.GraphQl.Queries
  import_types AppWeb.GraphQl.PaginationTypes
  import_types AppWeb.GraphQl.Types

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [HandleChangesetErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end

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

  subscription do
    # Blog
    import_fields :post_subscriptions
  end
end
