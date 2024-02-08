defmodule AppWeb.GraphQl.Schema.BasicDataSource do
  def source do
    Dataloader.Ecto.new(App.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
