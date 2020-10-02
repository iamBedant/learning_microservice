defmodule TaskMsElixirWeb.TaskView do
  use TaskMsElixirWeb, :view
  alias TaskMsElixirWeb.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      user_id: task.user_id,
      task_name: task.task_name}
  end
end
