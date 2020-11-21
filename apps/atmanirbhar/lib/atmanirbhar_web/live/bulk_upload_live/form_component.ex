defmodule AtmanirbharWeb.BulkUploadLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace

  def mount(socket) do
    {:ok, allow_upload(socket, :csv, accept: ~w(.csv), max_entries: 2 )}
  end

  @impl true
  def update(%{bulk_upload: bulk_upload} = assigns, socket) do
    changeset = Marketplace.change_bulk_upload(bulk_upload)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bulk_upload" => bulk_upload_params}, socket) do
    changeset =
      socket.assigns.bulk_upload
      |> Marketplace.change_bulk_upload(bulk_upload_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"bulk_upload" => bulk_upload_params}, socket) do
    save_bulk_upload(socket, socket.assigns.action, bulk_upload_params)
  end

  defp save_bulk_upload(socket, :edit, bulk_upload_params) do
    case Marketplace.update_bulk_upload(socket.assigns.bulk_upload, bulk_upload_params) do
      {:ok, _bulk_upload} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bulk upload updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_bulk_upload(socket, :new, bulk_upload_params) do
    case Marketplace.create_bulk_upload(bulk_upload_params) do
      {:ok, _bulk_upload} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bulk upload created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
