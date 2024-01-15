defmodule ExAbsWeb.GraphQl.Auth.UserTypes do
  @moduledoc false

  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:id)
    field :username, :string
  end

  object :user_pagination do
    field :entries, list_of(:user)
    field :metadata, :pagination_metadata
  end

  input_object :create_user_input do
    field :username, non_null(:string)
  end
end
