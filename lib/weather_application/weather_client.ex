defmodule WeatherApplication.WeatherClient do
  alias WeatherApplication.RequestParams

  @callback request(params :: RequestParams.t()) :: String.t()
end
