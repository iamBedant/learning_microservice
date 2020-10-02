defmodule TaskMsElixir.QuarantineTasksTest do
  use TaskMsElixir.DataCase

  alias TaskMsElixir.QuarantineTasks

  describe "tasks" do
    alias TaskMsElixir.QuarantineTasks.Task

    @valid_attrs %{task_name: "some task_name", user_id: 42}
    @update_attrs %{task_name: "some updated task_name", user_id: 43}
    @invalid_attrs %{task_name: nil, user_id: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> QuarantineTasks.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert QuarantineTasks.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert QuarantineTasks.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = QuarantineTasks.create_task(@valid_attrs)
      assert task.task_name == "some task_name"
      assert task.user_id == 42
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QuarantineTasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = QuarantineTasks.update_task(task, @update_attrs)
      assert task.task_name == "some updated task_name"
      assert task.user_id == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = QuarantineTasks.update_task(task, @invalid_attrs)
      assert task == QuarantineTasks.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = QuarantineTasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> QuarantineTasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = QuarantineTasks.change_task(task)
    end
  end
end
