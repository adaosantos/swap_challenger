defmodule Swap.Workers.GetRepoIssues do
  @moduledoc false

  use Kiq.Worker, queue: "default"

  @impl true
  def perform(args) do
    IO.inspect(args)
  end
end
