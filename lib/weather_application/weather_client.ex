defmodule WeatherApplication.WeatherClient do
  @moduledoc """
  Module describing the WeatherClient API
  """
  alias WeatherApplication.Data.Weather
  alias WeatherApplication.RequestParams

  @callback request(params :: RequestParams.t()) :: Weather.t()
end
