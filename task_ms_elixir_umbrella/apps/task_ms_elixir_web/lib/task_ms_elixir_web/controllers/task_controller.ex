defmodule TaskMsElixirWeb.TaskController do
  use TaskMsElixirWeb, :controller

  alias TaskMsElixir.QuarantineTasks
  alias TaskMsElixir.QuarantineTasks.Task

  action_fallback TaskMsElixirWeb.FallbackController

  def index(conn, _params) do
    tasks = QuarantineTasks.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- QuarantineTasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = QuarantineTasks.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = QuarantineTasks.get_task!(id)

    with {:ok, %Task{} = task} <- QuarantineTasks.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = QuarantineTasks.get_task!(id)

    with {:ok, %Task{}} <- QuarantineTasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
