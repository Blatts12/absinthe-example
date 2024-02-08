defmodule AppWeb.GraphQl.Schema do
  use Absinthe.Schema

  alias App.Accounts.User
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

  object :user do
    field :id, non_null(:id)
    field :email, :string
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)

    # field :posts, list_of(:post), resolve: &list_posts/3
    field :posts, list_of(:post) do
      arg :date, :date
      resolve &list_posts/3
    end
  end

  query do
    field :get_post, non_null(:post) do
      arg :id, non_null(:id)
      resolve &get_post/2
    end

    field :get_user, non_null(:user) do
      arg :id, non_null(:id)
      resolve &get_user/2
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

  def get_user(%{id: id}, _resolution) do
    case App.Accounts.get_user(id) do
      %User{} = user -> {:ok, user}
      _ -> {:error, :not_found}
    end
  end

  def get_post(%{id: id}, _resolution) do
    case App.Blog.get_post(id) do
      %Post{} = post -> {:ok, post}
      _ -> {:error, :not_found}
    end
  end

  def list_posts(%App.Accounts.User{} = author, args, _resolution) do
    {:ok, App.Blog.list_posts(author, args)}
  end

  def list_posts(_parent, args, _resolution) do
    {:ok, App.Blog.list_posts(args)}
  end
end
