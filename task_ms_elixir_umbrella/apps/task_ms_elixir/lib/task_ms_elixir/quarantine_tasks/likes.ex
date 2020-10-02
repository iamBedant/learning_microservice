defmodule TaskMsElixir.QuarantineTasks.Likes do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "task_likes" do
    field :reaction, :integer
    field :user_id, :integer, primary_key: true
    field :id, :id, primary_key: true

    timestamps()
  end
  
  @required_fields ~w(user_id id)

  @doc false
  def changeset(likes, attrs) do
    likes
    |> cast(attrs, [:id, :user_id, :reaction])
    |> validate_required([:id, :user_id, :reaction])
  end
end
