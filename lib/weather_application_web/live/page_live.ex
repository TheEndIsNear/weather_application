defmodule WeatherApplicationWeb.PageLive do
  use WeatherApplicationWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, zip: "", results: %{})}
  end

  @impl true
  def handle_event("search", %{"zip" => zip}, socket) do
    {:noreply, assign(socket, :zip, zip)}
  end
end
