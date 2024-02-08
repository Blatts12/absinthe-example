defmodule App.Blog.PostDataSource do
  import Ecto.Query
  alias App.Blog.Post

  def source do
    Dataloader.Ecto.new(App.Repo, query: &query/2)
  end

  def query(Post, _params) do
    from p in Post, where: p.title == "title-2"
  end

  # Fallback to default
  def query(queryable, _params) do
    queryable
  end
end
