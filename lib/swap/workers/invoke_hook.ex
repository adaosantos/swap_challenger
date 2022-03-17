defmodule Swap.Workers.InvokeHook do
  require Logger;

  alias Swap.Action;
  
  use Kiq.Worker, dead: true, queue: "hooks", retry: 5

  @impl Kiq.Worker
  def perform([user, repo_id, issues, contributors]) do
    Action.list_by_repo(repo_id)
  end
end
