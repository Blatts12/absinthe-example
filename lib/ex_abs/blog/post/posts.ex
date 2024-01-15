defmodule ExAbs.Blog.Posts do
  @moduledoc false

  use Contexted.CRUD,
    repo: ExAbs.Repo,
    schema: ExAbs.Blog.Post

  import Ecto.Query

  alias ExAbs.Blog.Post
  alias ExAbs.Repo
  alias ExAbs.Types

  @spec list_posts_by_user_id(Types.id()) :: [Post.t()]
  def list_posts_by_user_id(user_id) do
    query =
      from p in Post,
        where: p.user_id == ^user_id,
        select: p

    Repo.all(query)
  end
end
