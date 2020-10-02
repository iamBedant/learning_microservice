defmodule TaskMsElixir.Repo.Migrations.CreateTaskLikes do
  use Ecto.Migration

  def change do
    create table(:task_likes, primary_key: false) do
      add :user_id, :integer, primary_key: true
      add :reaction, :integer
      add :id, references(:tasks, on_delete: :nothing), primary_key: true

      timestamps()
    end

    create unique_index(:task_likes, [:user_id, :id])
  end
end
