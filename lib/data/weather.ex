defmodule WeatherApplication.Data.Weather do
  @moduledoc """
  Handles the schema and changeset for the weather information
  """
  use Ecto.Schema
  import Ecto.Changeset

  @valid_attrs [
    :temperature,
    :feels_like,
    :temp_min,
    :temp_max,
    :pressure,
    :humidity,
    :wind_speed,
    :gust,
    :unit,
    :location,
    :description
  ]

  @type t :: %__MODULE__{
          temperature: float(),
          feels_like: float(),
          temp_min: float(),
          temp_max: float(),
          pressure: float(),
          humidity: float(),
          wind_speed: float(),
          gust: float(),
          unit: String.t(),
          location: String.t(),
          description: String.t()
        }

  schema "weather" do
    field :temperature, :float
    field :feels_like, :float
    field :temp_min, :float
    field :temp_max, :float
    field :pressure, :float
    field :humidity, :float
    field :wind_speed, :float
    field :gust, :float
    field :unit, :string
    field :location, :string
    field :description, :string
    timestamps()
  end

  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> changeset(params)
  end

  def changeset(changeset, attrs) do
    changeset
    |> cast(attrs, @valid_attrs)
  end
end
