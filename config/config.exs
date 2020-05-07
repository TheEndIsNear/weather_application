# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :weather_application,
  ecto_repos: [WeatherApplication.Repo],
  openweather_api_key: System.get_env("OWM_API_KEY"),
  weather_client: WeatherApplication.OpenWeathermapClient.Client

# Configures the endpoint
config :weather_application, WeatherApplicationWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mI175+52LtnkInoO28XL3sbiSDvO5s12HXE8Z5MpSrER9lQrUpD5yeFzd5LkwCrV",
  render_errors: [view: WeatherApplicationWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: WeatherApplication.PubSub,
  live_view: [signing_salt: "Mc8z/qmf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
