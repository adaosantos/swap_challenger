defmodule Swap.Workers.RepoInfo do
  require Logger

  alias Swap.GithubRepository
  alias Swap.Workers.InvokeHook
  alias Swap.Workers.RepoInfo.{GetIssues, GetContributors}

  use Kiq.Worker, queue: "default"

  @impl true
  def perform(_) do
    GithubRepository.list_all()
    |> Enum.map(&get_info/1)
    |> Enum.each(&enqueue/1)
  end

  defp get_info(%GithubRepository{} = repository) do
    {:ok, issues: issues} = repository |> GetIssues.call
    {:ok, contributors: contributors} = repository |> GetContributors.call

    { :ok, user: repository.owner, repo_id: repository.id, issues: issues, contributors: contributors }
  end

  defp enqueue({:ok, user: user, repo_id: repo_id, issues: issues, contributors: contributors}) do
    InvokeHook.new([
      user,
      repo_id,
      issues,
      contributors
      ]) |> Swap.Kiq.enqueue#(in: 60 * 60 * 24)
  end

  defp enqueue(_), do: nil
end
