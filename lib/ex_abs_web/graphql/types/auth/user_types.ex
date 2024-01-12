defmodule ExAbsWeb.GraphQl.Auth.UserTypes do
  @moduledoc false

  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:id)
    field :username, :string
  end
end
