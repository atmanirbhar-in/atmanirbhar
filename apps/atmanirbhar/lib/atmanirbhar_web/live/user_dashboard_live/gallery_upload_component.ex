defmodule AtmanirbharWeb.UserDashboardLive.GalleryUploadComponent do
  use AtmanirbharWeb, :live_component
  alias Atmanirbhar.Marketplace

  # maybe here is problem?
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

  def handle_event("cancel-entry", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :picture, ref)}
  end

  def handle_event("save",
    %{"gallery_upload" => gallery_params} = params,
    socket) do
    # save creates new records
    # and stores to DB
    IO.puts "save gallery_upload"

    {:noreply, socket}
  end



end









