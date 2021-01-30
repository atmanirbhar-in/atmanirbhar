defmodule AtmanirbharWeb.StallLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.{Advertisement, Deal, LocationForm}
  alias Atmanirbhar.Geo.Location
  alias Atmanirbhar.Presence

  @impl true
  def mount(params, session, socket) do
    {:ok, socket}
  end

  def handle_params(params, url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, %{"stall_id" => stall_id}) do
    stall = Marketplace.load_stall(stall_id)
    products = Marketplace.list_products(stall.stall_atlas.product_ids)
    medias = Marketplace.list_media(stall.stall_atlas.media_ids)

    socket
    |> assign(:page_title, stall.title)
    |> assign(:business, stall.business)
    |> assign(:stall_title, stall.title)
    |> assign(:stall_description, stall.description)
    |> assign(:products, products)
    |> assign(:medias, medias)
  end

  defp apply_action(socket, :pincode, params) do
    pincode = params["pincode"] |> String.to_integer
    socket
    |> assign(:page_title, pincode)
  end


  # def grouped_gallery_items([]), do: %{1 => [], 2 => []}
  # def grouped_gallery_items(elements), do: elements |> Enum.group_by(&Map.get(&1, :type))

end
