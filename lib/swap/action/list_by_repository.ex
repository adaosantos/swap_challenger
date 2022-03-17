defmodule Swap.Action.ListByRepository do
  import Ecto.Query

  alias Swap.Repo

  def call(repo_id) do
    Swap.Action
    |> where([a], a.repository_id == ^repo_id)
    |> Repo.all()
  end
end
