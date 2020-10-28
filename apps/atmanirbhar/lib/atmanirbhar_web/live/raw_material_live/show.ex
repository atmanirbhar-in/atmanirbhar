defmodule AtmanirbharWeb.RawMaterialLive.Show do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Resources

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:raw_material, Resources.get_raw_material!(id))}
  end

  defp page_title(:show), do: "Show Raw material"
  defp page_title(:edit), do: "Edit Raw material"
end
