defmodule TaskMsElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TaskMsElixir.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TaskMsElixir.PubSub}
      # Start a worker by calling: TaskMsElixir.Worker.start_link(arg)
      # {TaskMsElixir.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: TaskMsElixir.Supervisor)
  end
end
