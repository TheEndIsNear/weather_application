defmodule WeatherApplicationWeb.PageLive do
  @moduledoc """
  Module for controlling  the display of the weather on the front page
  """
  use WeatherApplicationWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, zip: "", temperature: "", results: %{})}
  end

  @impl true
  @spec handle_event(<<_::48>>, map, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_event("search", %{"zip" => zip}, socket) do
    temperature = parse_weather(zip)

    {:noreply, assign(socket, zip: zip, temperature: temperature)}
  end

  @spec parse_weather(String.t()) :: String.t()
  defp parse_weather(zip) do
    api_key = Application.get_env(:weather_application, :openweather_api_key)

    url =
      String.to_charlist(
        "http://api.openweathermap.org/data/2.5/weather?zip=#{zip}&units=imperial&appid=#{api_key}"
      )

    {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}} = :httpc.request(:get, {url, []}, [], [])

    {:ok, %{"main" => %{"temp" => temp}}} =
      body
      |> List.to_string()
      |> Jason.decode()

    temp
  end
end
