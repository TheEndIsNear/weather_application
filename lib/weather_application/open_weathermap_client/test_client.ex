defmodule WeatherApplication.OpenWeathermapClient.TestClient do
  @moduledoc """
  A module to be used for testing to simulate the connection to open weather map
  """
  @behaviour WeatherApplication.WeatherClient

  alias WeatherApplication.Data.Weather
  alias WeatherApplication.RequestParams

  @impl true
  def request(%RequestParams{units: "imperial"} = _params) do
    %{temperature: 80.0, location: "Albuquerque"}
    |> Weather.changeset()
    |> Ecto.Changeset.apply_action!(:create)
  end

  def request(%RequestParams{units: "metric"} = _params) do
    %{temperature: 20.0, location: "Albuquerque"}
    |> Weather.changeset()
    |> Ecto.Changeset.apply_action!(:create)
  end

  def request(%RequestParams{} = _params) do
    %{temperature: 300.0, location: "Albuquerque"}
    |> Weather.changeset()
    |> Ecto.Changeset.apply_action!(:create)
  end
end
