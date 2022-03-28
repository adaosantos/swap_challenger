# Swap Application

# Setup
## Partial Docker
- `docker-compose up -d redis postgres`
- `mix ecto.create`
- `mix ecto.migrate`
- `mix run priv/repo/seeds.exs`
- `mix run --no-halt`

## Full Docker
- `docker-compose up -d redis postgres`
- `docker-compose run --rm application mix ecto.create`
- `docker-compose run --rm application mix ecto.migrate`
- `docker-compose run --rm application mix run priv/repo/seeds.exs`
- `docker-compose up application` *You can use -d option to detach container and see logs with `docker-compose logs application -f`

## Debugging
- `docker-compose run --rm application iex -S mix` *Maybe you need stop the application with `docker-compose stop application`

You can use `require IEx; IEx.pry` to put "break points" at code.

## Webhooks
You can see webhooks calls on [Webhook.Site](https://webhook.site/#!/cb5f529f-e0f6-4bf4-8901-33c4b56cf15a/12c334e1-82ff-4574-90c4-718dd079ef9c/)

If you prefer change this link on `priv/database/seeds.exs` and run `docker-compose run --rm application mix run priv/repo/seeds.exs`

## Github Auth
Unfortunaly the Github have a limitation at 20 requests per day if you don't use any authorization method, I choose to use the Basic Auth through personal Token, to generate this token follow this [guide](https://docs.github.com/pt/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token), after this step, fill the env vars `GITHUB_USERNAME` and `GITHUB_TOKEN`, if you like you can create a `env.local` file and fill it