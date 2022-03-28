FROM elixir:1.13.3-slim

RUN mkdir /src
COPY . /src
WORKDIR /src

RUN mix local.hex --force && mix local.rebar --force && mix deps.get
RUN mix do compile

EXPOSE 4000

CMD ["mix", "run", "--no-halt"]