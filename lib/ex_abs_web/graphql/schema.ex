defmodule ExAbsWeb.GraphQl.Schema do
  @moduledoc false

  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  alias Absinthe.Type
  alias ExAbs.Accounts
  alias ExAbsWeb.GraphQl.HandleErrors
  alias ExAbsWeb.GraphQl.Schema.BasicDataSource

  node interface do
    resolve_type fn
      %{__typename: schema_name} -> schema_name
    end
  end

  # Upload type
  import_types Absinthe.Plug.Types

  # Custom types (datetime, native_datetime, etc.)
  import_types Absinthe.Type.Custom

  import_types ExAbsWeb.GraphQl.Types
  import_types ExAbsWeb.GraphQl.ScalarTypes
  import_types ExAbsWeb.GraphQl.Queries
  import_types ExAbsWeb.GraphQl.Mutations
  import_types ExAbsWeb.GraphQl.Subscriptions

  query do
    # Accounts
    import_fields :user_queries
  end

  mutation do
    # Accounts
    import_fields :user_token_mutations
  end

  # subscription do
  # end

  @spec context(map()) :: map()
  def context(context) do
    loader =
      Dataloader.add_source(Dataloader.new(), Accounts.User, BasicDataSource.data())

    Map.put(context, :loader, loader)
  end

  @spec plugins() :: list(Absinthe.Plugin.t())
  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  @spec middleware(list(Absinthe.Middleware.spec()), Type.Field.t(), Type.Object.t()) :: list(Absinthe.Middleware.spec())
  def middleware(middleware, _, %{identifier: identifier}) do
    add_error_handler(middleware, identifier)
  end

  defp add_error_handler(middleware, _identifier) do
    middleware ++ [HandleErrors]
  end
end
