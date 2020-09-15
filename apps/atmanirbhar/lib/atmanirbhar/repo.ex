defmodule Atmanirbhar.Repo do
  use Ecto.Repo,
    otp_app: :atmanirbhar,
    adapter: Ecto.Adapters.Postgres
end
