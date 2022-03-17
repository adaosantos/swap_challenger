defmodule Swap.Action.ListAll do
  alias Swap.Repo

  def call() do
    Swap.Action
    |> Repo.all()
  end
end
