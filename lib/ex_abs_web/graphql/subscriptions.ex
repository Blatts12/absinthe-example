defmodule ExAbsWeb.GraphQl.Subscriptions do
  @moduledoc false

  use Absinthe.Schema.Notation

  import_types ExAbsWeb.GraphQl.Auth.UserSubscriptions
end
