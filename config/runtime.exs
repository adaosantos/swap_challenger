import Config

Vapor.load!([%Vapor.Provider.Dotenv{}])

config :swap, :kiq,
  redis_url: System.get_env("REDIS_URL")

config :swap, Swap.Repo,
  username: System.get_env("DB_USER") || "postgres",
  password: System.get_env("DB_PASSWORD") || "postgres",
  hostname: System.get_env("DB_HOST") || "localhost",
  port: System.get_env("DB_PORT") || 5432,
  database: System.get_env("DB_NAME") || "swap_#{Mix.env}"
