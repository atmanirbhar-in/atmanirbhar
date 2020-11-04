defmodule Atmanirbhar.Presence do
  use Phoenix.Presence, otp_app: :atmanirbhar, pubsub_server: Atmanirbhar.PubSub
end

