defmodule ExAbsWeb.GraphQl.Schema do
  @moduledoc false

  use Absinthe.Schema

  import_types(ExAbsWeb.GraphQl.Types)
  import_types(ExAbsWeb.GraphQl.Queries)
  import_types(ExAbsWeb.GraphQl.Mutations)

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end
end
