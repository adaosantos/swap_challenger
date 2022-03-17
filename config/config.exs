import Config

config :swap, ecto_repos: [Swap.Repo]

config :swap, :github,
  url: "https://api.github.com",
  username: "adaosantos",
  access_token: "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"

import_config "#{config_env()}.exs"
