defmodule AtmanirbharWeb.UserDashboardLive.Gallery do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.GalleryUpload
  alias Atmanirbhar.Marketplace

  def mount(_params, session, socket) do
    user_token = session
    |> Map.get("user_token")

    all_picture_albums = Marketplace.list_user_gallery_items(user_token)

    {
      :ok,
      socket
      |> assign(:user_token, user_token)
      |> assign(:picture_albums, all_picture_albums)
    }
  end

  def handle_params(_params, _url, socket) do
    {
      :noreply,
      apply_action(socket, socket.assigns.live_action, %{})
    }
  end

  defp apply_action(socket, :gallery, _params) do
    socket
  end

  defp apply_action(socket, :new_picture, _params) do
    # all_picture_albums = Marketplace.list_user_gallery_items(socket.assigns.user_token)
    socket
    |> assign(:page_title, "Upload pictures")
    |> assign(:gallery_upload, %GalleryUpload{})
  end



end










