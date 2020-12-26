defmodule AtmanirbharWeb.BulkUploadLive.Show do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bulk_upload, Marketplace.get_bulk_upload!(id))}
  end

  defp page_title(:show), do: "Show Bulk upload"
  defp page_title(:edit), do: "Edit Bulk upload"
end
