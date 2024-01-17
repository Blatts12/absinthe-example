defmodule ExAbsWeb.GraphQl.Schema.Type do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      use Absinthe.Schema.Notation
      use Absinthe.Relay.Schema.Notation, :modern

      import Absinthe.Resolution.Helpers

      alias Absinthe.Relay.Node.ParseIDs
      alias ExAbsWeb.GraphQl.Authenticated
    end
  end
end
