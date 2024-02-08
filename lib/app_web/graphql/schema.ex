defmodule AppWeb.GraphQl.Schema do
  use Absinthe.Schema

  alias App.Blog.Post

  # datetime, native_datetime, decimal
  import_types Absinthe.Type.Custom

  object :post do
    field :title, :string
    field :id, non_null(:id)
    field :user_id, non_null(:id)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end

  input_object :create_post_input do
    field :title, non_null(:string)
    field :user_id, non_null(:id)
  end

  query do
    field :get_post, non_null(:post) do
      arg :id, non_null(:id)

      resolve fn %{id: id}, _ ->
        case App.Blog.get_post(id) do
          %Post{} = post -> {:ok, post}
          _ -> {:error, :not_found}
        end
      end
    end
  end

  mutation do
    field :create_post, non_null(:post) do
      arg :input, non_null(:create_post_input)

      resolve fn %{input: args}, _ -> App.Blog.create_post(args) end
    end
  end

  # subscription do
  # end
end
