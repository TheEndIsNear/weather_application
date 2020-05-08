defmodule WeatherApplication.OpenWeathermapClient.TestClient do
  @moduledoc """
  A module to be used for testing to simulate the connection to open weather map
  """
  @behaviour WeatherApplication.WeatherClient

  alias WeatherApplication.RequestParams

  @impl true
  def request(%RequestParams{units: "imperial"} = _params) do
    "80"
  end

  def request(%RequestParams{units: "metric"} = _params) do
    "20"
  end

  def request(%RequestParams{} = _params) do
    "300"
  end
end
