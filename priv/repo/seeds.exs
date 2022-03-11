alias Swap.Repo
alias Swap.GithubRepository

Repo.delete_all(GithubRepository)

Swap.GithubRepository.changeset(%{ name: "phoenix", owner: "phoenixframework" })
  |> Swap.Repo.insert

Swap.GithubRepository.changeset(%{ name: "elixir", owner: "elixir-lang" })
  |> Swap.Repo.insert
