# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :task_ms_elixir,
  ecto_repos: [TaskMsElixir.Repo]

config :task_ms_elixir_web,
  ecto_repos: [TaskMsElixir.Repo],
  generators: [context_app: :task_ms_elixir]

# Configures the endpoint
config :task_ms_elixir_web, TaskMsElixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D6VafedMlWMZFqTsFwyfTFqhbv9+l8/I2RfToEnOHzBAzdtA10/44kM4waHfVSgc",
  render_errors: [view: TaskMsElixirWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TaskMsElixir.PubSub,
  live_view: [signing_salt: "sqBBvKZ0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
