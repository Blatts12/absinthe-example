defmodule AppWeb.GraphQl.Schema do
  use Absinthe.Schema

  # datetime, native_datetime, decimal
  import_types Absinthe.Type.Custom

  object :post do
    field :title, :string
    field :id, non_null(:id)
    field :user_id, non_null(:id)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end

  query do
    field :get_post, :post do
      arg :id, non_null(:id)

      resolve fn %{id: id}, _ -> {:ok, App.Blog.get_post(id)} end
    end
  end

  mutation do
    field :create_post, non_null(:post) do
      arg :title, non_null(:string)
      arg :user_id, non_null(:id)

      resolve fn args, _ -> App.Blog.create_post(args) end
    end
  end

  # subscription do
  # end
end
