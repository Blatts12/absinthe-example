defmodule ExAbsWeb.SubscriptionCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      use ExAbsWeb.ChannelTest
      use Absinthe.Phoenix.SubscriptionTest, schema: ExAbsWeb.GraphQl.Schema

      @spec subscribe(Socket.t(), String.t(), Keyword.t()) :: binary()
      defp subscribe(socket, query, options \\ []) do
        ref = push_doc(socket, query, options)
        assert_reply(ref, :ok, %{subscriptionId: subscription_id})

        subscription_id
      end

      @spec close_socket(Socket.t()) :: :ok
      defp close_socket(%Socket{} = socket) do
        Process.unlink(socket.channel_pid)
        close(socket)
      end
    end
  end
end
