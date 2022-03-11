defmodule Swap.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Swap.{Kiq}

  @impl true
  def start(_type, _args) do
    Vapor.load!([%Vapor.Provider.Dotenv{}])

    children = [
      # Starts a worker by calling: Swap.Worker.start_link(arg)
      # {Swap.Worker, arg}
      Swap.Repo
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Swap.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
