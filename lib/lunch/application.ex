defmodule Lunch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  use Commanded.Application,
    otp_app: :lunch,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Lunch.EventStore
    ]

  @impl true
  def start(_type, _args) do
    children = [
      # Start Commanded application
      Lunch.Core.Application,

      # Start the Ecto repository
      Lunch.Repo,
      # Start the Telemetry supervisor
      LunchWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lunch.PubSub},
      # Start the Endpoint (http/https)
      LunchWeb.Endpoint,
      {Absinthe.Subscription, LunchWeb.Endpoint},

      # Start a worker by calling: Lunch.Worker.start_link(arg)
      # {Lunch.Worker, arg}

      # Start Accounts Projector
      Lunch.Accounts.Projectors.User,

      # Start Sales Supervisor
      Lunch.Sales.Supervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lunch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LunchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
