defmodule MyPersonalCloudBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MyPersonalCloudBackendWeb.Telemetry,
      MyPersonalCloudBackend.Repo,
      {DNSCluster,
       query: Application.get_env(:my_personal_cloud_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MyPersonalCloudBackend.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MyPersonalCloudBackend.Finch},
      # Start a worker by calling: MyPersonalCloudBackend.Worker.start_link(arg)
      # {MyPersonalCloudBackend.Worker, arg},
      # Start to serve requests, typically the last entry
      MyPersonalCloudBackendWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyPersonalCloudBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MyPersonalCloudBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
