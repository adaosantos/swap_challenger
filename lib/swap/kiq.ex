defmodule Swap.Kiq do
  @moduledoc false

  use Kiq,
    pool_size: 5,
    queues: [default: 25],
    periodics: [{"* * * * *", Swap.Workers.GetRepoIssues}]
end
