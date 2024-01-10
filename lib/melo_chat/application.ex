defmodule MeloChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MeloChatWeb.Telemetry,
      MeloChat.Repo,
      {DNSCluster, query: Application.get_env(:chat, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MeloChat.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MeloChat.Finch},
      # Start a worker by calling: MeloChat.Worker.start_link(arg)
      # {MeloChat.Worker, arg},
      # Start to serve requests, typically the last entry
      MeloChatWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MeloChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MeloChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
