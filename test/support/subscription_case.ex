defmodule AppWeb.SubscriptionCase do
  use ExUnit.CaseTemplate

  alias Absinthe.Phoenix.SubscriptionTest
  alias Phoenix.ChannelTest
  alias Phoenix.Socket

  require Phoenix.ChannelTest

  using do
    quote do
      use AppWeb.ChannelCase
      use Absinthe.Phoenix.SubscriptionTest, schema: AppWeb.GraphQl.Schema

      import AppWeb.GraphQlHelpers

      defp create_socket(params \\ %{}) do
        {:ok, socket} = ChannelTest.connect(AppWeb.UserSocket, params)
        {:ok, socket} = SubscriptionTest.join_absinthe(socket)

        socket
      end

      defp subscribe(socket, query, options \\ []) do
        ref = push_doc(socket, query, options)
        assert_reply(ref, :ok, %{subscriptionId: subscription_id})

        subscription_id
      end

      defp close_socket(%Socket{} = socket) do
        # Socket will be closed automatically but we can do it manually
        # It's useful when we want to test, for example, users with different roles in a loop
        Process.unlink(socket.channel_pid)
        close(socket)
      end
    end
  end
end
