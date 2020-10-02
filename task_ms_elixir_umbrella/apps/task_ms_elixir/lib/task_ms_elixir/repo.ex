defmodule TaskMsElixir.Repo do
  use Ecto.Repo,
    otp_app: :task_ms_elixir,
    adapter: Ecto.Adapters.Postgres
end
