defmodule AppWeb.GraphQl.Blog.PostResolvers do
  alias App.Accounts.User
  alias App.Blog
  alias App.Blog.Post

  def get_post(%{id: id}, _resolution) do
    case Blog.get_post(id) do
      %Post{} = post -> {:ok, post}
      _ -> {:error, :not_found}
    end
  end

  def list_posts(%User{} = author, args, _resolution) do
    {:ok, Blog.list_posts(author, args)}
  end

  def list_posts(_parent, args, _resolution) do
    {:ok, Blog.list_posts(args)}
  end

  def create_post(args, %{context: %{current_user: %{id: user_id}}}) do
    args = Map.put(args, :user_id, user_id)

    with {:ok, %Post{} = post} <- Blog.create_post(args) do
      {:ok, %{post: post}}
    end
  end

  def paginate_posts(args, _resolution) do
    Blog.paginate_posts(args)
  end

  def update_post(args, %{context: %{resource: post}}) do
    with {:ok, post} <- Blog.update_post(post, args) do
      {:ok, %{post: post}}
    end
  end
end
