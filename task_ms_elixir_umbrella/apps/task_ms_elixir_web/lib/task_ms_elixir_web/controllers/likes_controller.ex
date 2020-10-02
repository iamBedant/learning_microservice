defmodule TaskMsElixirWeb.LikesController do
    use TaskMsElixirWeb, :controller
  
    alias TaskMsElixir.QuarantineTasks
    alias TaskMsElixir.QuarantineTasks.Likes

    def reactToTask(conn, %{"like" => like_params}) do
        with {:ok, %Likes{} = like} <- QuarantineTasks.update_likes(like_params) do
          conn
          |>put_status(:created)
          |>render("like.json", like: like)
        end
    end
end