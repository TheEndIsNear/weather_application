defmodule WeatherApplicationWeb.PageLive do
  @moduledoc """
  Module for controlling  the display of the weather on the front page
  """
  use WeatherApplicationWeb, :live_view

  alias WeatherApplication.RequestParams

  @impl true
  def mount(_params, _session, socket) do
    changeset = RequestParams.changeset(%RequestParams{}, %{units: "imperial", zip: ""})
    {:ok, assign(socket, units: "imperial", temperature: "", results: %{}, changeset: changeset)}
  end

  @impl true
  def handle_event("search", %{"request_params" => params}, socket) do
    changeset = RequestParams.changeset(params)

    case changeset.valid? do
      true ->
        {:ok, request_params} = Ecto.Changeset.apply_action(changeset, :create)
        temperature = client().request(request_params)
        {:noreply, assign(socket, temperature: temperature, changeset: changeset)}

      false ->
        {:noreply, assign(socket, changeset: %{changeset | action: :create})}
    end
  end

  @impl true
  def handle_event("unit-selected", %{"value" => units}, socket) do
    {:noreply, assign(socket, :units, units)}
  end

  defp client, do: Application.get_env(:weather_application, :weather_client)
end
