defmodule ExAbsWeb.GraphQl.Schema.Type do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      use Absinthe.Schema.Notation

      import Absinthe.Resolution.Helpers
    end
  end
end
