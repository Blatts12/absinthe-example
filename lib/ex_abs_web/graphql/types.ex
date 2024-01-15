defmodule ExAbsWeb.GraphQl.Types do
  @moduledoc """
  All absinthe types are imported here
  """

  use Absinthe.Schema.Notation

  # Auth
  import_types ExAbsWeb.GraphQl.Auth.UserTypes

  # Blog
  import_types ExAbsWeb.GraphQl.Blog.PostTypes
end
