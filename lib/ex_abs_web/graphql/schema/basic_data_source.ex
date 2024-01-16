defmodule ExAbsWeb.GraphQl.Schema.BasicDataSource do
  @moduledoc false

  @spec data() :: Dataloader.Ecto.t()
  def data do
    Dataloader.Ecto.new(ExAbs.Repo, query: &query/2)
  end

  @spec query(Ecto.Query.t(), map()) :: Ecto.Query.t()
  def query(queryable, _params) do
    queryable
  end
end
