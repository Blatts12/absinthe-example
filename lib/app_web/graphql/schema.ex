defmodule AppWeb.GraphQl.Schema do
  use Absinthe.Schema

  # datetime, native_datetime, decimal
  import_types Absinthe.Type.Custom

  object :post do
    field :title, :string
    field :id, non_null(:id)
    field :user_id, non_null(:id)
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  # query do
  # end

  # mutation do
  # end

  # subscription do
  # end
end
