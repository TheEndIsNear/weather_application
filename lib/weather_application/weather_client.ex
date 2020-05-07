defmodule WeatherApplication.WeatherClient do
  @moduledoc """
  Module describing the WeatherClient API
  """
  alias WeatherApplication.RequestParams

  @callback request(params :: RequestParams.t()) :: String.t()
end
