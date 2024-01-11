defmodule ExAbsWeb.GraphQl.Schema do
  @moduledoc false

  use Absinthe.Schema

  @desc "example object"
  object :example do
    @desc "example field"
    field :value, :string
  end

  query do
    @desc "example query"
    field :example_query, :example do
      arg(:example_arg, :string)

      resolve(fn _, _, _ ->
        {:ok, %{value: "example"}}
        # {:error, "Invalid data, example"}
      end)
    end
  end

  # mutation do
  # end
end
