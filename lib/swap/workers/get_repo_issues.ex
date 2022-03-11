defmodule Swap.Workers.GetRepoIssues do
  require Logger

  alias Swap.GithubRepository

  use Kiq.Worker, queue: "default"

  @impl true
  def perform(_) do
    GithubRepository.list_all()
    |> Enum.map(&get_issues/1)
  end

  defp get_issues(%GithubRepository{} = repository) do
    url =
      repository
      |> build_url

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Jason.decode!(body, keys: :atoms)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.warning("Repository #{repository.owner}/#{repository.name} not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error(reason)
    end
  end

  defp build_url(%GithubRepository{} = repository) do
    api_url = Application.get_env(:swap, :github)[:url]
    "#{api_url}/repos/#{repository.owner}/#{repository.name}/issues"
  end
end
