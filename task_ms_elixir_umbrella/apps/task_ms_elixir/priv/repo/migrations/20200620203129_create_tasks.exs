defmodule TaskMsElixir.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :user_id, :integer
      add :task_name, :string

      timestamps()
    end

  end
end
