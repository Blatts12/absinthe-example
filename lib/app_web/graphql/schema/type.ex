defmodule AppWeb.GraphQl.Schema.Type do
  defmacro __using__(_opts) do
    quote do
      use AppWeb.GraphQl.Schema.Type

      import Absinthe.Resolution.Helpers
    end
  end
end
