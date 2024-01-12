defmodule ExAbsWeb.GraphQl.Mutations do
  @moduledoc false

  use Absinthe.Schema.Notation

  # Auth
  import_types(ExAbsWeb.GraphQl.Auth.UserMutations)
end
