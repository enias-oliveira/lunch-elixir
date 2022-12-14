# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :lunch,
  ecto_repos: [Lunch.Repo],
  event_stores: [Lunch.Core.EventStore]

config :lunch, Lunch.Core.Application,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: Lunch.Core.EventStore
  ]

config :lunch, Lunch.Core.EventStore, serializer: Commanded.Serialization.JsonSerializer

config :lunch, Lunch.Repo, migration_primary_key: [type: :binary_id]
config :lunch, Lunch.Repo, migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :lunch, LunchWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: LunchWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Lunch.PubSub,
  live_view: [signing_salt: "XSGwpTGK"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :lunch, Lunch.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :commanded, event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections, repo: Lunch.Repo

config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
    --config=tailwind.config.js
    --input=css/app.css
    --output=../priv/static/assets/app.css
  ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
