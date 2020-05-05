defmodule WeatherApplication.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      WeatherApplication.Repo,
      # Start the Telemetry supervisor
      WeatherApplicationWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: WeatherApplication.PubSub},
      # Start the Endpoint (http/https)
      WeatherApplicationWeb.Endpoint
      # Start a worker by calling: WeatherApplication.Worker.start_link(arg)
      # {WeatherApplication.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WeatherApplication.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WeatherApplicationWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
