import Config

config :swap, ecto_repos: [Swap.Repo]

config :swap, :github,
  url: "https://api.github.com",
  username: "adaosantos",
  access_token: "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"

import_config "#{config_env()}.exs"
