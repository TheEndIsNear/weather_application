defmodule WeatherApplication.WeatherClient do
  @moduledoc """
  Module describing the WeatherClient API
  """
  alias WeatherApplication.RequestParams
  alias WeatherApplication.Weather

  @callback request(params :: RequestParams.t()) :: Weather.t()
end
