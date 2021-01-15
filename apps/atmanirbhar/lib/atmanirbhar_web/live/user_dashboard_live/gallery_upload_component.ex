defmodule AtmanirbharWeb.UserDashboardLive.GalleryUploadComponent do
  use AtmanirbharWeb, :live_component

  # socket, session, params?
  def update(%{gallery_upload: input_gallery_upload} = assigns, socket) do
    changeset = Atmanirbhar.Marketplace.change_gallery_upload(input_gallery_upload)
    {:ok, socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end


end
