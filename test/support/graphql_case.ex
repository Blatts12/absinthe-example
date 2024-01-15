defmodule ExAbsWeb.GraphQlCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      use ExAbsWeb.ConnCase

      import ExAbsWeb.GraphQlHelpers
    end
  end
end
