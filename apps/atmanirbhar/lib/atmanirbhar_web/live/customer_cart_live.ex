defmodule AtmanirbharWeb.CustomerCartLive do
  use AtmanirbharWeb, :live_view

  def mount(params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def apply_action(socket, :cart, params) do
    socket
  end

end
