defmodule AppWeb.GraphQl.PaginationTypes do
  use AppWeb.GraphQl.Schema.Type

  object :pagination_metadata do
    field :after, :string
    field :before, :string
    field :limit, :integer
    field :total_count, :integer
    field :total_count_cap_exceeded, :boolean
  end

  input_object :pagination_input do
    field :after, :string
    field :before, :string
    field :limit, :integer
    field :include_total_count, :boolean
  end
end
