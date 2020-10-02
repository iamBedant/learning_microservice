defmodule TaskMsElixirWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TaskMsElixirWeb.Telemetry,
      # Start the Endpoint (http/https)
      TaskMsElixirWeb.Endpoint
      # Start a worker by calling: TaskMsElixirWeb.Worker.start_link(arg)
      # {TaskMsElixirWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TaskMsElixirWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TaskMsElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
