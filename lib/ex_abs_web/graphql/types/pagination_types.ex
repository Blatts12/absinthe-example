defmodule ExAbsWeb.GraphQl.PaginationTypes do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  object :pagination_metadata do
    @desc "An opaque cursor representing the last row of the current page."
    field :after, :string

    @desc "An opaque cursor representing the first row of the current page"
    field :before, :string

    @desc "The maximum number of entries that can be contained in this page"
    field :limit, :integer

    @desc "The total number of entries matching the query"
    field :total_count, :integer

    @desc "A boolean indicating whether the total_count_limit was exceeded"
    field :total_count_cap_exceeded, :boolean
  end

  input_object :pagination_input do
    field :after, :string
    field :before, :string

    @desc "Number of records to return, default 20"
    field :limit, :integer

    @desc "Should the total count be included in the response? This is an expensive operation, default false"
    field :include_total_count, :boolean
  end
end
