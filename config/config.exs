# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :atmanirbhar,
  ecto_repos: [Atmanirbhar.Repo]

# Configures the endpoint
config :atmanirbhar, AtmanirbharWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fi3WS1GueDLkVqTKlT8GfqWTMaYBWdYf92IU/nHQExuZ/wif6OPk3KvDHL5ywKX5",
  render_errors: [view: AtmanirbharWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Atmanirbhar.PubSub,
  live_view: [signing_salt: "ZZfCCIhx"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :waffle,
  # or Waffle.Storage.Local
  storage: Waffle.Storage.S3,
  # if using S3
  bucket: System.get_env("AWS_BUCKET_NAME")

# If using S3:
config :ex_aws,
  json_codec: Jason,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  region: System.get_env("AWS_REGION")

config :atmanirbhar, Atmanirbhar.Mailer,
  adapter: Bamboo.MandrillAdapter,
  api_key: "my_api_key"

config :kaffy,
  otp_app: :atmanirbhar,
  ecto_repo: Atmanirbhar.Repo,
  router: AtmanirbharWeb.Router,
  admin_title: "Admanirbhar Dashboard",
  admin_logo: "/images/atmanirbhar-logo-wide.png",
  admin_logo_mini: "/images/atmanirbhar-logo.png"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
