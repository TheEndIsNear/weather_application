defmodule WeatherApplication.Controller do
  alias WeatherApplication.Data.Weather
  alias WeatherApplication.Repo

  def insert_weather(%Weather{} = weather) do
    Repo.insert(weather)
  end
end
