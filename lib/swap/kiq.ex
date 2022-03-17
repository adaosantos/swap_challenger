defmodule Swap.Kiq do
  @moduledoc false

  use Kiq,
    pool_size: 5,
    queues: [default: 5, hooks: 5],
    periodics: [{"* * * * *", Swap.Workers.RepoInfo}]
end
