defmodule ExAbsWeb.GraphQl.Schema do
  @moduledoc false

  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  alias Absinthe.Type
  alias ExAbs.Auth
  alias ExAbs.Blog
  alias ExAbsWeb.GraphQl.HandleErrors
  alias ExAbsWeb.GraphQl.Schema.BasicDataSource

  node interface do
    resolve_type fn
      %{__typename: schema_name} -> schema_name
    end
  end

  import_types ExAbsWeb.GraphQl.Types
  import_types ExAbsWeb.GraphQl.PaginationTypes

  import_types ExAbsWeb.GraphQl.Queries
  import_types ExAbsWeb.GraphQl.Mutations
  import_types ExAbsWeb.GraphQl.Subscriptions

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

  @spec context(map()) :: map()
  def context(context) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Auth.User, BasicDataSource.data())
      |> Dataloader.add_source(Blog.Post, Blog.PostDataSource.data())

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
