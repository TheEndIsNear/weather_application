defmodule WeatherApplication.Repo do
  use Ecto.Repo,
    otp_app: :weather_application,
    adapter: Ecto.Adapters.Postgres
end
