defmodule ExAbsWeb.GraphQl.Blog.PostResolvers do
  @moduledoc false

  alias ExAbs.Blog
  alias ExAbs.Blog.Post

  @spec create_post(map(), map()) :: {:ok, Post.t()} | {:error, term()}
  def create_post(args, %{context: %{current_user: %{id: user_id}}}) do
    args = Map.put(args, :user_id, user_id)
    IO.inspect(args)

    with {:ok, %Post{} = post} <- Blog.create_post(args) do
      {:ok, %{post: post}}
    end
  end

  def create_post(_, _) do
    {:error, :unauthorized}
  end
end
