defmodule AtmanirbharWeb.GalleryLive.Index do
  use AtmanirbharWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _url, socket) do
    {
      :noreply,
      apply_action(socket, socket.assigns.live_action, %{})
    }
  end

  def apply_action(socket, :index, _params) do
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

end
