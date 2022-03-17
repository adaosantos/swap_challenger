defmodule Swap.Workers.RepoInfo.GetContributors do
  require Logger;
  alias Swap.GithubRepository

  def call(%GithubRepository{} = repository) do
    repository
    |> build_url
    |> Swap.Github.Client.get()
    |> parse
  end

  defp build_url(%GithubRepository{} = repository) do
    "/repos/#{repository.owner}/#{repository.name}/contributors"
  end

  defp parse({:error, %HTTPoison.Error{reason: reason}}) do
    Logger.error(reason)
    {:error}
  end

  defp parse({:ok, %HTTPoison.Response{status_code: 401}}) do
    Logger.error("Unauthorized :(")
    {:error}
  end

  defp parse({:ok, %HTTPoison.Response{status_code: 404}}) do
    Logger.error("Repository not found :(")
    {:error}
  end

  defp parse({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    contributors =
      body
      |> Jason.decode!(keys: :atoms)
      |> Enum.map(fn c ->
        %{ user: c.login, qtd_commits: c.contributions}
      end)

    {:ok, contributors: contributors}
  end
end
