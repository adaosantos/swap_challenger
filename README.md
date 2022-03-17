# Swap Application

# Setup
- ``docker-compose up -d redis postgres``
- `mix ecto.create`
- `mix ecto.migrate`
- `mix run priv/repo/seeds.exs`
- `mix run --no-halt`
