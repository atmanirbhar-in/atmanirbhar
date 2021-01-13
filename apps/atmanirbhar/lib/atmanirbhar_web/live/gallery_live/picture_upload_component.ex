defmodule AtmanirbharWeb.PictureUploadComponent do
  use AtmanirbharWeb, :live_component
  alias Atmanirbhar.Marketplace.StallItem

  #form

  def update(%{picture_upload: picture_upload} = assigns, socket) do
    # create changeset?
    # form, live-upload
    changeset = Marketplace.change_stall_item(picture_upload)

    {:ok,
     socket
     |> assign(changeset: changeset)
    }
  end

  def handle_event("validate", %{"picture_upload" => picture_upload_params}, socket) do
    changeset = socket.assigns.gallery
    |> Marketplace.change_stall_item(picture_upload_params)
    |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"picture_upload" => picture_upload_params}, socket) do
    save_gallery(socket, socket.assigns.live_action, picture_upload_params)
  end

  defp save_gallery(socket, :new, params) do
    #
  end

  defp save_gallery(socket, :edit, params) do
    #
  end

  # IMP phx-target : at-self
  # else it goes to parent
  def handle_event("picture-pictures", params, socket) do
    {:noreply, socket}
  end


end
