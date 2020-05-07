defmodule WeatherApplicationWeb.PageLive do
  @moduledoc """
  Module for controlling  the display of the weather on the front page
  """
  use WeatherApplicationWeb, :live_view

  alias WeatherApplication.RequestParams

  @base_url "http://api.openweathermap.org/data/2.5/weather?"

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, zip: "", temperature: "", units: "imperial", results: %{})}
  end

  @impl true
  def handle_event("search", %{"zip" => zip}, %{assigns: %{units: units}} = socket) do
    temperature = parse_weather(%RequestParams{zip: zip, units: units})

    {:noreply, assign(socket, zip: zip, temperature: temperature)}
  end

  @impl true
  def handle_event("unit-selected", %{"value" => units}, socket) do
    {:noreply, assign(socket, :units, units)}
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
