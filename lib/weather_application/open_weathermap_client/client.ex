defmodule WeatherApplication.OpenWeathermapClient.Client do
  @moduledoc """
  Implement the Weather client behaviour for connecting to the open weather map api.
  """
  @behaviour WeatherApplication.WeatherClient

  alias Ecto.Changeset
  alias WeatherApplication.RequestParams
  alias WeatherApplication.Data.Weather

  @base_url "http://api.openweathermap.org/data/2.5/weather?"

  @impl true
  def request(%RequestParams{} = params) do
    json_map = make_request(params)

    {:ok, weather} =
      %Weather{}
      |> parse_temperature(json_map)
      |> parse_location(json_map)
      |> parse_temp_max(json_map)
      |> parse_temp_min(json_map)
      |> parse_pressure(json_map)
      |> parse_humidity(json_map)
      |> parse_feels_like(json_map)
      |> parse_wind_speed(json_map)
      |> parse_description(json_map)
      |> Changeset.apply_action(:create)

    weather
  end

  defp make_request(%RequestParams{zip: zip} = params) do
    case zip do
      "" ->
        %{}

      _zip ->
        url = create_url(params)
        {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}} = :httpc.request(:get, {url, []}, [], [])

        {:ok, json_map} =
          body
          |> List.to_string()
          |> Jason.decode()

        json_map
    end
  end

  defp parse_temperature(changeset, %{"main" => %{"temp" => temp}}) do
    Weather.changeset(changeset, %{temperature: temp})
  end

  defp parse_temp_max(changeset, %{"main" => %{"temp_max" => temp_max}}) do
    Weather.changeset(changeset, %{temp_max: temp_max})
  end

  defp parse_temp_min(changeset, %{"main" => %{"temp_min" => temp_min}}) do
    Weather.changeset(changeset, %{temp_min: temp_min})
  end

  defp parse_pressure(changeset, %{"main" => %{"pressure" => pressure}}) do
    Weather.changeset(changeset, %{pressure: pressure})
  end

  defp parse_humidity(changeset, %{"main" => %{"humidity" => humidity}}) do
    Weather.changeset(changeset, %{humidity: humidity})
  end

  defp parse_feels_like(changeset, %{"main" => %{"feels_like" => feels_like}}) do
    Weather.changeset(changeset, %{feels_like: feels_like})
  end

  defp parse_wind_speed(changeset, %{"wind" => %{"speed" => wind_speed}}) do
    Weather.changeset(changeset, %{wind_speed: wind_speed})
  end

  defp parse_location(changeset, %{"name" => location}) do
    Weather.changeset(changeset, %{location: location})
  end

  defp parse_description(changeset, %{"weather" => [%{"description" => description}]}) do
    Weather.changeset(changeset, %{description: description})
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
