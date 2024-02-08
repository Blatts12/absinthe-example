defmodule AppWeb.GraphQl.Schema.Type do
  defmacro __using__(_opts) do
    quote do
      use Absinthe.Schema.Notation
      use Absinthe.Relay.Schema.Notation, :modern

      import Absinthe.Resolution.Helpers
    end
  end
end
