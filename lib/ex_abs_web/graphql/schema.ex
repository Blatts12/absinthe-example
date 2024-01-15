defmodule ExAbsWeb.GraphQl.Schema do
  @moduledoc false

  use Absinthe.Schema

  alias Absinthe.Type
  alias ExAbsWeb.GraphQl.HandleErrors

  import_types ExAbsWeb.GraphQl.Types
  import_types ExAbsWeb.GraphQl.Queries
  import_types ExAbsWeb.GraphQl.Mutations
  import_types ExAbsWeb.GraphQl.Subscriptions
  import_types ExAbsWeb.GraphQl.PaginationTypes

  query do
    # Auth
    import_fields :user_queries
  end

  mutation do
    # Auth
    import_fields :user_mutations

    # Blog
    import_fields :post_mutations
  end

  subscription do
    # Auth
    import_fields :user_subscriptions
  end

  @spec middleware(list(Absinthe.Middleware.spec()), Type.Field.t(), Type.Object.t()) :: list(Absinthe.Middleware.spec())
  def middleware(middleware, _, %{identifier: identifier}) do
    add_error_handler(middleware, identifier)
  end

  defp add_error_handler(middleware, _identifier) do
    middleware ++ [HandleErrors]
  end
end
