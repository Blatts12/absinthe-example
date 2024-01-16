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
end
