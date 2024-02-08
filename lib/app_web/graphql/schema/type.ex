defmodule AppWeb.GraphQl.Schema.Type do
  defmacro __using__(_opts) do
    quote do
      use Absinthe.Schema.Notation
      use Absinthe.Relay.Schema.Notation, :modern

      import Absinthe.Resolution.Helpers

      alias AppWeb.GraphQl.Middleware.Authenticated
      alias AppWeb.GraphQl.Middleware.Unauthenticated
      alias AppWeb.GraphQl.Middleware.LoadResource
      alias Absinthe.Relay.Node.ParseIDs
    end
  end
end
