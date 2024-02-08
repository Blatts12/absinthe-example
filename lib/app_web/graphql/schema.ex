defmodule AppWeb.GraphQl.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  alias App.Blog
  alias App.Accounts
  alias AppWeb.GraphQl.Middleware.HandleChangesetErrors
  alias AppWeb.GraphQl.Schema.BasicDataSource

  node interface do
    resolve_type fn
      %Blog.Post{}, _ -> :post
      %Accounts.User{}, _ -> :user
      _, _ -> nil
    end
  end

  # datetime, native_datetime, decimal
  import_types Absinthe.Type.Custom

  import_types AppWeb.GraphQl.Mutations
  import_types AppWeb.GraphQl.Subscriptions
  import_types AppWeb.GraphQl.Queries
  import_types AppWeb.GraphQl.ScalarTypes
  import_types AppWeb.GraphQl.Types

  query do
    node field do
      resolve fn
        %{type: :user, id: id}, _ ->
          {:ok, App.Accounts.get_user(id)}

        %{type: :post, id: id}, _ ->
          {:ok, App.Blog.get_post(id)}

        _, _ ->
          {:error, :invalid_global_id}
      end
    end

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
