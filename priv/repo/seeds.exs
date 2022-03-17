alias Swap.Repo
alias Swap.GithubRepository
alias Swap.Action

Repo.delete_all(GithubRepository)
Repo.delete_all(Action)

GithubRepository.changeset(%{ name: "phoenix", owner: "phoenixframework" })
  |> Swap.Repo.insert!

GithubRepository.changeset(%{ name: "elixir", owner: "elixir-lang" })
  |> Swap.Repo.insert!

GithubRepository.list_all
  |> Enum.each(fn g ->
      Action.changeset(%{
        name: "Default Hook",
        event: "issues",
        url: "https://webhook.site/5fe632b4-5ce6-4abb-8cb2-341e40e9c497",
        repository_id: g.id})
      |> Swap.Repo.insert!
    end)
