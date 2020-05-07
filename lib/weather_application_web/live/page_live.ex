defmodule WeatherApplicationWeb.PageLive do
  @moduledoc """
  Module for controlling  the display of the weather on the front page
  """
  use WeatherApplicationWeb, :live_view

  alias WeatherApplication.RequestParams

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, zip: "", temperature: "", units: "imperial", results: %{})}
  end

  @impl true
  def handle_event("search", %{"zip" => zip}, %{assigns: %{units: units}} = socket) do
    temperature = client().request(%RequestParams{zip: zip, units: units})

    {:noreply, assign(socket, zip: zip, temperature: temperature)}
  end

  @impl true
  def handle_event("unit-selected", %{"value" => units}, socket) do
    {:noreply, assign(socket, :units, units)}
  end

  defp client, do: Application.get_env(:weather_application, :weather_client)
end
