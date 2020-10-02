defmodule TaskMsElixirWeb.LikesView do
    use TaskMsElixirWeb, :view
    alias TaskMsElixirWeb.LikesView
    
    def render("like.json", %{like: like}) do
      %{status: "success",
        liked_task: like.id}
    end
  end
  