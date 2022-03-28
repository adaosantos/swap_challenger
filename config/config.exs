import Config

config :swap, ecto_repos: [Swap.Repo]

import_config "#{config_env()}.exs"
