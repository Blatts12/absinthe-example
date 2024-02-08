defmodule AppWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import AppWeb.ChannelCase

      # The default endpoint for testing
      @endpoint AppWeb.Endpoint
    end
  end

  setup tags do
    App.DataCase.setup_sandbox(tags)
    :ok
  end
end
