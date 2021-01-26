defmodule AtmanirbharWeb.UserDashboardLive.Gallery do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.GalleryUpload
  alias Atmanirbhar.Marketplace
  alias AtmanirbharWeb.UserDashboardLive.FoldersNavigationComponent

  def mount(%{"business_id" => business_id} = params, session, socket) do
    socket = socket
    |> MountHelpers.assign_defaults(params, session, [:upload_pictures, :view_gallery])

    # is business_id string? should be integer

    all_media = Marketplace.list_business_media(business_id)

    {
      :ok,
      socket
      |> assign(:business_id, business_id)
      |> assign(:media_items, all_media)
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










