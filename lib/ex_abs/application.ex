defmodule ExAbs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExAbsWeb.Telemetry,
      ExAbs.Repo,
      {DNSCluster, query: Application.get_env(:ex_abs, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ExAbs.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ExAbs.Finch},
      # Start a worker by calling: ExAbs.Worker.start_link(arg)
      # {ExAbs.Worker, arg},
      # Start to serve requests, typically the last entry
      ExAbsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExAbs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExAbsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
