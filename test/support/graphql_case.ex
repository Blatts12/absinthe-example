defmodule AppWeb.GraphQlCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use AppWeb.ConnCase

      import AppWeb.GraphQlHelpers
    end
  end
end
