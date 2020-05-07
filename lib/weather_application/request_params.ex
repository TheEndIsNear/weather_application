defmodule WeatherApplication.RequestParams do
  @moduledoc """
  Module for handling all of the request params being passed to open weather map
  """
  defstruct zip: "", units: "imperial"

  @type t(zip, units) :: %__MODULE__{zip: zip, units: units}
  @type t :: %__MODULE__{zip: String.t(), units: String.t()}
end
