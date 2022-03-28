alias Swap.Repo
alias Swap.GithubRepository
alias Swap.Action

Repo.delete_all(Action)
Repo.delete_all(GithubRepository)

GithubRepository.changeset(%{ name: "phoenix", owner: "phoenixframework" })
  |> Swap.Repo.insert!

GithubRepository.changeset(%{ name: "elixir", owner: "elixir-lang" })
  |> Swap.Repo.insert!

GithubRepository.list_all
  |> Enum.each(fn g ->
      Action.changeset(%{
        name: "Default Hook",
        event: "issues",
        url: "https://webhook.site/cb5f529f-e0f6-4bf4-8901-33c4b56cf15a",
        repository_id: g.id})
      |> Swap.Repo.insert!
    end)
