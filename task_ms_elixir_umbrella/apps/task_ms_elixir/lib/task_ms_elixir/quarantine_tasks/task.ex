defmodule TaskMsElixir.QuarantineTasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :task_name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:user_id, :task_name])
    |> validate_required([:user_id, :task_name])
  end
end
