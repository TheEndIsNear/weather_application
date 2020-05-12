defmodule WeatherApplication.OpenWeathermapClient.TestClient do
  @moduledoc """
  A module to be used for testing to simulate the connection to open weather map
  """
  @behaviour WeatherApplication.WeatherClient

  alias WeatherApplication.RequestParams
  alias WeatherApplication.Data.Weather

  @impl true
  def request(%RequestParams{units: "imperial"} = _params) do
    %Weather{temperature: 80.0, location: "Albuquerque"}
  end

  def request(%RequestParams{units: "metric"} = _params) do
    %Weather{temperature: 20.0, location: "Albuquerque"}
  end

  def request(%RequestParams{} = _params) do
    %Weather{temperature: 300.0, location: "Albuquerque"}
  end
end
