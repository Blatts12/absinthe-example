defmodule AppWeb.GraphQl.Schema do
  use Absinthe.Schema

  alias App.Blog
  alias AppWeb.GraphQl.Middleware.HandleChangesetErrors
  alias AppWeb.GraphQl.Schema.BasicDataSource

  # datetime, native_datetime, decimal
  import_types Absinthe.Type.Custom

  import_types AppWeb.GraphQl.Mutations
  import_types AppWeb.GraphQl.Subscriptions
  import_types AppWeb.GraphQl.Queries
  import_types AppWeb.GraphQl.PaginationTypes
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

  subscription do
    # Blog
    import_fields :post_subscriptions
  end

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [HandleChangesetErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end

  def context(context) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(:basic, BasicDataSource.source())
      |> Dataloader.add_source(Blog.Post, Blog.PostDataSource.source())

    Map.put(context, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
