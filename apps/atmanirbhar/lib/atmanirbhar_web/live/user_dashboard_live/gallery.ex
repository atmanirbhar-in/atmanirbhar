defmodule AtmanirbharWeb.UserDashboardLive.Gallery do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.GalleryUpload
  alias Atmanirbhar.Marketplace

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _url, socket) do
    {
      :noreply,
      apply_action(socket, socket.assigns.live_action, %{})
    }
  end

  defp apply_action(socket, :gallery, _params) do
    user_id = 1
    all_picture_albums = Marketplace.list_user_gallery_items(user_id)

    socket
    |> assign(:picture_albums, all_picture_albums)
  end
  defp apply_action(socket, :new_picture, _params) do
    user_id = 1
    all_pictures = []
    all_picture_albums = Marketplace.list_user_gallery_items(user_id)
    socket
    # |> assign(assigns)
    |> assign(:page_title, "Upload pictures")
    |> assign(:gallery_upload, %GalleryUpload{})
    |> assign(:picture_albums, all_picture_albums)
  end



end










