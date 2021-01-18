defmodule AtmanirbharWeb.UserDashboardLive.Index do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.{Advertisement, Deal, Business, GalleryItem, Stall}
  alias Atmanirbhar.Marketplace

  @impl true
  def mount(_params, session, socket) do
    user_token = session
    |> Map.get("user_token")

    user_businesses_n_stalls = user_token
    |> Atmanirbhar.Marketplace.list_user_businesses
    |> Enum.group_by(&Map.get(&1, :business))

    {:ok,
     assign(socket, businesses_kv: user_businesses_n_stalls)
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit config")
  end

  defp apply_action(socket, :index, %{}) do
    socket
    |> assign(:page_title, "My Dashboard - my Businesses and Stalls")
  end

  defp apply_action(socket, :new_timeline_post, _params) do
    socket
    |> assign(:page_title, "New Timeline Post")
    |> assign(:gallery_item, %GalleryItem{})
  end
  defp apply_action(socket, :new_product, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:gallery_item, %GalleryItem{})
  end
  defp apply_action(socket, :new_stall, _params) do
    socket
    |> assign(:page_title, "create new stall")
    |> assign(:stall, %Stall{})
  end
  defp apply_action(socket, :edit_stall, %{"stall_id" => input_stall_id}) do
    {stall_id, _} = Integer.parse(input_stall_id)
    stall = Marketplace.get_stall_detail!(stall_id)

    socket
    |> assign(:page_title, "Edit Stall")
    |> assign(:stall, stall)
  end

  defp apply_action(socket, :edit_stall_media, %{"stall_id" => input_stall_id}) do
    {stall_id, _} = Integer.parse(input_stall_id)

    socket
    |> assign(:page_title, "Edit Stall")
    |> assign(:stall_id, stall_id)
  end

  defp apply_action(socket, :edit_business, %{"business_id" => input_business_id}) do
    cities = Atmanirbhar.Geo.list_cities()
    {business_id, _} = Integer.parse(input_business_id)
    business = Marketplace.get_business!(input_business_id)

    socket
    |> assign(:page_title, "Edit business")
    |> assign(:business, business)
    |> assign(:cities, cities)
  end

  defp apply_action(socket, :new_business, _params) do
    cities = Atmanirbhar.Geo.list_cities()

    socket
    |> assign(:page_title, "List your business")
    |> assign(:business, %Business{})
    |> assign(:cities, cities)
  end

  def handle_event("recover_wizard", params, socket) do
    {:noreply, socket}
  end

end
