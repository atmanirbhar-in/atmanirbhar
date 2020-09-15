defmodule AtmanirbharWeb.PincodeLive.Show do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Geo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pincode, Geo.get_pincode!(id))}
  end

  defp page_title(:show), do: "Show Pincode"
  defp page_title(:edit), do: "Edit Pincode"
end
