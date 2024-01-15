defmodule ExAbsWeb.GraphQl.Blog.PostResolvers do
  @moduledoc false

  alias ExAbs.Blog
  alias ExAbs.Blog.Post

  @spec create_post(map(), map()) :: {:ok, Post.t()} | {:error, term()}
  def create_post(%{input: args}, _resolution) do
    with {:ok, %Post{} = post} <- Blog.create_post(args) do
      {:ok, post}
    end
  end

  @spec list_posts(map(), map(), map()) :: {:ok, [Post.t()]}
  def list_posts(%{id: user_id}, _args, _resolution) do
    {:ok, Blog.list_posts_by_user_id(user_id)}
  end

  def list_posts(_parent, _args, _resolution) do
    {:ok, []}
  end
end
