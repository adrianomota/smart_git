defmodule SmartGit.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SmartGit.Repo,
      # Start the Telemetry supervisor
      SmartGitWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SmartGit.PubSub},
      # Start the Endpoint (http/https)
      SmartGitWeb.Endpoint
      # Start a worker by calling: SmartGit.Worker.start_link(arg)
      # {SmartGit.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SmartGit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SmartGitWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
