defmodule Swap.GithubRepository.ListAll do
  alias Swap.Repo

  def call() do
    Swap.GithubRepository
    |> Repo.all()
  end
end
