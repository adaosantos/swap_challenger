defmodule Swap.Workers.InvokeHook do
  @moduledoc false

  use Kiq.Worker, dead: true, queue: "hooks", retry: 5

  @impl true
  def perform(args) do
    IO.inspect(args)
  end
end
