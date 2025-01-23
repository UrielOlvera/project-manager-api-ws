# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :project_manager_api_ws,
  ecto_repos: [ProjectManagerApiWs.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :project_manager_api_ws, ProjectManagerApiWsWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: ProjectManagerApiWsWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ProjectManagerApiWs.PubSub,
  live_view: [signing_salt: "TdbTZzIQ"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :project_manager_api_ws, ProjectManagerApiWs.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :project_manager_api_ws, ProjectManagerApiWs.Guardian,
  issuer: "project_manager_api_ws",
  secret_key: "8GcY0tWzzUm8osM1dvnw2hsCrGBS0pQjdxXS9qoM5JPVCGQdnWoCuYflYy5NiSKk"


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
