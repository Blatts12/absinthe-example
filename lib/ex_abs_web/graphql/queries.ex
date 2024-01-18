defmodule ExAbsWeb.GraphQl.Queries do
  @moduledoc """
  All absinthe queries are imported here
  """

  use Absinthe.Schema.Notation

  # Accounts
  import_types ExAbsWeb.GraphQl.Accounts.UserQueries
end
