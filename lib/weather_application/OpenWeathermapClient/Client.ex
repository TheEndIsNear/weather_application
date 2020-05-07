defmodule WeatherApplication.OpenWeathermapClient.Client do
  @moduledoc """
  Implement the Weather client behaviour for connecting to the open weather map api.
  """
  @behaviour WeatherApplication.WeatherClient

  alias WeatherApplication.RequestParams

  @base_url "http://api.openweathermap.org/data/2.5/weather?"

  @impl true
  def request(%RequestParams{} = params) do
    parse_weather(params)
  end

  @spec parse_weather(map()) :: String.t()
  defp parse_weather(%RequestParams{zip: zip} = params) do
    case zip do
      "" ->
        ""

      _zip ->
        url = create_url(params)
        {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}} = :httpc.request(:get, {url, []}, [], [])

        {:ok, %{"main" => %{"temp" => temp}}} =
          body
          |> List.to_string()
          |> Jason.decode()

        temp
    end
  end

  @spec create_url(RequestParams.t()) :: charlist()
  defp create_url(%RequestParams{zip: zip, units: units}) do
    String.to_charlist("#{base_url()}zip=#{zip}&units=#{units}&appid=#{api_key()}")
  end

  @spec base_url() :: String.t()
  defp base_url, do: @base_url

  @spec api_key() :: String.t()
  defp api_key, do: Application.get_env(:weather_application, :openweather_api_key)
end
