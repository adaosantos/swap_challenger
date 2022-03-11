import Config

config :swap, ecto_repos: [Swap.Repo]

config :swap, :github, url: "https://api.github.com"

import_config "#{config_env()}.exs"
