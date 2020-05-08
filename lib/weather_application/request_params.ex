defmodule WeatherApplication.RequestParams do
  @moduledoc """
  Module for handling all of the request params being passed to open weather map
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t(zip, units) :: %__MODULE__{zip: zip, units: units}
  @type t :: %__MODULE__{zip: String.t(), units: String.t()}

  schema "request_params" do
    field :zip, :string
    field :units, :string
  end

  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> changeset(params)
  end

  def changeset(request_params, attrs) do
    request_params
    |> cast(attrs, [:zip, :units])
    |> validate_required([:zip])
    |> validate_format(:zip, ~r/^[0-9]{5}(?:-[0-9]{4})?$/)
  end
end
