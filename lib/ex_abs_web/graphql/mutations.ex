defmodule ExAbsWeb.GraphQl.Mutations do
  @moduledoc false

  use Absinthe.Schema.Notation

  # Accounts
  import_types ExAbsWeb.GraphQl.Accounts.UserTokenMutations
end
