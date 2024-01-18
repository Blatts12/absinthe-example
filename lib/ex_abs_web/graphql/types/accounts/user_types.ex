defmodule ExAbsWeb.GraphQl.Accounts.UserTypes do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  node object(:user) do
    field :email, non_null(:string)
    field :confirmed_at, :naive_datetime
  end
end
