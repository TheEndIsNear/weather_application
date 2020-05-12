defmodule WeatherApplication.Repo.Migrations.CreateWeatherTable do
  use Ecto.Migration

  def change do
    create table(:weather) do
      add :temperature, :float
      add :feels_like, :float
      add :temp_min, :float
      add :temp_max, :float
      add :pressure, :float
      add :humidity, :float
      add :wind_speed, :float
      add :gust, :float
      add :unit, :string
      add :location, :string
      add :description, :string

      timestamps
    end
  end
end
