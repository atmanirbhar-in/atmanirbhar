defmodule AtmanirbharWeb.UserDashboardLive.GalleryUploadComponent do
  use AtmanirbharWeb, :live_component
  alias Atmanirbhar.Marketplace

  def mount(socket) do
    {:ok,
     allow_upload(socket, :picture, accept: [".png", ".jpg"], max_entries: 4)
    }
  end

  # socket, session, params?
  def update(%{gallery_upload: input_gallery_upload} = assigns, socket) do
    changeset = Atmanirbhar.Marketplace.change_gallery_upload(input_gallery_upload)
    {:ok, socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def handle_event("validate", %{"gallery_upload" => gallery_upload_params}, socket) do
    changeset =
      socket.assigns.gallery_upload
      |> Marketplace.change_gallery_upload(gallery_upload_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

end
