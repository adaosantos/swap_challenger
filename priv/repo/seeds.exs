alias Swap.Repo
alias Swap.Schemas.GithubRepository

Repo.delete_all(GithubRepository)

Swap.Schemas.GithubRepository.changeset(
  %Swap.Schemas.GithubRepository{},
  %{ name: "phoenix", owner: "phoenixframework" })
|> Swap.Repo.insert

Swap.Schemas.GithubRepository.changeset(
  %Swap.Schemas.GithubRepository{},
  %{ name: "elixir", owner: "elixir-lang" })
|> Swap.Repo.insert
