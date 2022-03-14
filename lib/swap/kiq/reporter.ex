defmodule Swap.Kiq.Reporter do
  require Logger

  use Kiq.Reporter

  @impl Kiq.Reporter
  def handle_failure(job, error, stacktrace, state) do
    metadata = Map.take(job, [:jid, :class, :args, :queue, :retry_count])

    :ok = Logger.error(%{ error: error, stacktrace: stacktrace})

    state
  end
end
