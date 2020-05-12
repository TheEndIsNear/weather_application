defmodule WeatherApplication.Controller do
  @moduledoc """
  The module responsbible for inserting and retriving weather data
  """
  alias WeatherApplication.Data.Weather
  alias WeatherApplication.Repo

  def insert_weather(%Weather{} = weather) do
    Repo.insert(weather)
  end
end
