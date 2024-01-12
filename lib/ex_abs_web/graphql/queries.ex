defmodule ExAbsWeb.GraphQl.Queries do
  @moduledoc """
  All absinthe queries are imported here
  """

  use Absinthe.Schema.Notation

  # Auth
  import_types(ExAbsWeb.GraphQl.Auth.UserQueries)
end
