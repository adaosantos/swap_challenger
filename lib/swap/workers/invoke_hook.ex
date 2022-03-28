defmodule Swap.Workers.InvokeHook do
  require Logger;

  alias Swap.Action;

  use Kiq.Worker, dead: true, queue: "hooks", retry: 5

  @impl Kiq.Worker
  def perform([user, repo_id, issues, contributors]) do
    Action.list_by_repo(repo_id)
    |> Enum.map ( fn (act) -> call_hook(act, issues, contributors) end)
  end

  defp call_hook(act, issues, contributors) do
    HTTPoison.post! act.url, build_body(issues, contributors), headers
  end

  defp build_body(issues, contributors) do
    %{ issues: issues, contributors: contributors }
    |> Jason.encode!
  end

  defp headers do
    [{"Content-Type", "application/json"}]
  end
end
