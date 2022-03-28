import Config

config :swap, ecto_repos: [Swap.Repo]

config :swap, :github,
  url: "https://api.github.com",
  username: "adaosantos",
  access_token: "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"

import_config "#{config_env()}.exs"
