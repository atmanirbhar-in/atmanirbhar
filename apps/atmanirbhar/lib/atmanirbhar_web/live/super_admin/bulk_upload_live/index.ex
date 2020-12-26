defmodule AtmanirbharWeb.BulkUploadLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.BulkUpload

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :marketplace_bulk_uploads, list_marketplace_bulk_uploads())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bulk upload")
    |> assign(:bulk_upload, Marketplace.get_bulk_upload!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bulk upload")
    |> assign(:bulk_upload, %BulkUpload{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Marketplace bulk uploads")
    |> assign(:bulk_upload, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bulk_upload = Marketplace.get_bulk_upload!(id)
    {:ok, _} = Marketplace.delete_bulk_upload(bulk_upload)

    {:noreply, assign(socket, :marketplace_bulk_uploads, list_marketplace_bulk_uploads())}
  end

  defp list_marketplace_bulk_uploads do
    Marketplace.list_marketplace_bulk_uploads()
  end
end
