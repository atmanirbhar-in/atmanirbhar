defmodule Atmanirbhar.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Atmanirbhar.Repo,
      # Start the Telemetry supervisor
      AtmanirbharWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Atmanirbhar.PubSub},
      # Start Presence process
      Atmanirbhar.Presence,
      # Start the Endpoint (http/https)
      AtmanirbharWeb.Endpoint
      # Start a worker by calling: Atmanirbhar.Worker.start_link(arg)
      # {Atmanirbhar.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Atmanirbhar.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AtmanirbharWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
