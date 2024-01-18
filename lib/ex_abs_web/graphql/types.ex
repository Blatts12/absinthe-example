defmodule ExAbsWeb.GraphQl.Types do
  @moduledoc """
  All absinthe types are imported here
  """

  use Absinthe.Schema.Notation

  # Accounts
  import_types ExAbsWeb.GraphQl.Accounts.UserTypes
  import_types ExAbsWeb.GraphQl.Accounts.UserTokenTypes
end
