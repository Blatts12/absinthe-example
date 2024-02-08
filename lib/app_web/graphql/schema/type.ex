defmodule AppWeb.GraphQl.Schema.Type do
  defmacro __using__(_opts) do
    quote do
      use Absinthe.Schema.Notation

      import Absinthe.Resolution.Helpers
    end
  end
end
