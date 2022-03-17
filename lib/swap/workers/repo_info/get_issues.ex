defmodule Swap.Workers.RepoInfo.GetIssues do
  require Logger;
  
  alias Swap.GithubRepository

  def call(%GithubRepository{} = repository) do
    repository
    |> build_url
    |> Swap.Github.Client.get()
    |> parse
  end

  defp build_url(%GithubRepository{} = repository) do
    "/repos/#{repository.owner}/#{repository.name}/issues"
  end

  defp parse({:error, %HTTPoison.Error{reason: reason}}), do: Logger.error(reason)
  {:error}

  defp parse({:ok, %HTTPoison.Response{status_code: 404}}),
    do: Logger.error("Repository not found :(")

  {:error}

  defp parse({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    issues =
      body
      |> Jason.decode!(keys: :atoms)
      |> Enum.map(fn i ->
        %{ title: i.title, author: i.user.login, labels: Enum.map(i.labels, fn l -> l.name end)}
      end)

    {:ok, issues: issues}
  end
end
