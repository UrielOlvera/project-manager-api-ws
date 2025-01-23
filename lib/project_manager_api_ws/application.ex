defmodule ProjectManagerApiWs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProjectManagerApiWsWeb.Telemetry,
      ProjectManagerApiWs.Repo,
      {DNSCluster, query: Application.get_env(:project_manager_api_ws, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ProjectManagerApiWs.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ProjectManagerApiWs.Finch},
      # Start a worker by calling: ProjectManagerApiWs.Worker.start_link(arg)
      # {ProjectManagerApiWs.Worker, arg},
      # Start to serve requests, typically the last entry
      ProjectManagerApiWsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProjectManagerApiWs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProjectManagerApiWsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
