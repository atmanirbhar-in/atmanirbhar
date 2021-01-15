defmodule AtmanirbharWeb.UserDashboardLive.Gallery do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.GalleryUpload

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
    # all_pictures = Marketplace.list_pictures()
    picture = %{
      title: "lorel ipseum",
      description: "taken at xyz",
      url: "/images/something.jpg"
    }
    all_pictures = [picture, picture]

    socket
    |> assign(:pictures, all_pictures)
  end
  defp apply_action(socket, :new_picture, _params) do
    all_pictures = []
    socket
    |> assign(:page_title, "Upload pictures")
    |> assign(:gallery_upload, %GalleryUpload{})
    |> assign(:pictures, all_pictures)
  end

end
