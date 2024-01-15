defmodule ExAbsWeb.SubscriptionCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  alias Absinthe.Phoenix.SubscriptionTest
  alias Phoenix.ChannelTest
  alias Phoenix.Socket

  require Phoenix.ChannelTest

  using do
    quote do
      use ExAbsWeb.ChannelCase
      use Absinthe.Phoenix.SubscriptionTest, schema: ExAbsWeb.GraphQl.Schema

      import ExAbsWeb.GraphQlHelpers

      @spec create_socket() :: Socket.t()
      @spec create_socket(map()) :: Socket.t()
      defp create_socket(params \\ %{}) do
        {:ok, socket} = ChannelTest.connect(ExAbsWeb.UserSocket, params)
        {:ok, socket} = SubscriptionTest.join_absinthe(socket)

        socket
      end

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
