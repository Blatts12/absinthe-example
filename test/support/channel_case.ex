defmodule ExAbsWeb.ChannelCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  using do
    quote do
      import ExAbs.Factory
      import ExAbsWeb.ChannelCase
      import Phoenix.ChannelTest

      # The default endpoint for testing
      @endpoint ExAbsWeb.Endpoint
    end
  end

  setup tags do
    ExAbs.DataCase.setup_sandbox(tags)
    :ok
  end
end
