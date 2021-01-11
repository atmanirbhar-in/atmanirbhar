defmodule AtmanirbharWeb.UserDashboardLive.Index do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.{Advertisement, Deal, Business, StallElement, Stall}
  alias Atmanirbhar.Marketplace

  @impl true
  def mount(_params, _session, socket) do
    businesses = Marketplace.list_user_businesses(1)

    {:ok, assign(socket,
        my_plugins: [],
        businesses: businesses,
        marketplace_bulk_uploads: Marketplace.list_marketplace_bulk_uploads()
      )
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
    |> assign(:stall_element, %StallElement{})
  end
  defp apply_action(socket, :new_product, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:stall_element, %StallElement{})
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
