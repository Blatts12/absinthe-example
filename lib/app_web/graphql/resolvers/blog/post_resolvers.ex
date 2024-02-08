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

  def create_post(%{input: args}, _resolution) do
    # Change args in some way
    with {:ok, %Post{} = post} <- Blog.create_post(args) do
      # Do anything else
      {:ok, post}
    end

    # This will return changeset errors
  end
end
