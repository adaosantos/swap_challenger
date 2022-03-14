defmodule Swap.Workers.GetRepoIssues do
  require Logger

  alias Swap.GithubRepository
  alias Swap.Workers.InvokeHook

  use Kiq.Worker, queue: "default"

  @impl true
  def perform(_) do
    GithubRepository.list_all()
    |> Enum.map(&get_issues/1)
  end

  def get_issues(%GithubRepository{} = repository) do
    repository
      |> build_url
      |> Swap.Github.Client.get
      |> extract_issues
      |> enqueue
  end

  def build_url(%GithubRepository{} = repository) do
    "/repos/#{repository.owner}/#{repository.name}/issues"
  end

  def extract_issues({:error, %HTTPoison.Error{reason: reason}}), do: Logger.error(reason); {:error}
  def extract_issues({:ok, %HTTPoison.Response{status_code: 404}}), do: Logger.error("Repository not found :("); {:error}
  def extract_issues({:ok, %HTTPoison.Response{status_code: 200, body: body}}), do: {:ok,  issues: body }

  def enqueue({:ok, issues: issues}) when is_binary(issues) do
    InvokeHook.new(issues) |> Swap.Kiq.enqueue(in: 60 * 60 * 24)
  end

  def enqueue({:error}), do: nil
end
