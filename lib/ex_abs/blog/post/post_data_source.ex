defmodule ExAbs.Blog.PostDataSource do
  @moduledoc false

  import Ecto.Query

  alias ExAbs.Blog.Post

  @spec data() :: Dataloader.Ecto.t()
  def data do
    Dataloader.Ecto.new(ExAbs.Repo, query: &query/2)
  end

  @spec query(Ecto.Query.t(), map()) :: Ecto.Query.t()
  def query(Post, _params) do
    from p in Post, where: p.title == "eldoka"
  end

  def query(queryable, _params) do
    queryable
  end
end
