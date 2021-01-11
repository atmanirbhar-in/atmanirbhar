defmodule AtmanirbharWeb.UserDashboardLive.Index do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.{Advertisement, Deal, Business, StallElement, Stall}
  alias Atmanirbhar.Marketplace

  @impl true
  def mount(_params, _session, socket) do
    businesses = Marketplace.list_user_businesses(1)

    #   %Business{
    #   title: "Mobile spares",
    #   description: "Trendy mobile accessories, Cases,Earphones, charging cables",
    #   address: "xyz, near ABC, Pune",
    # }
    stalls = List.first(businesses).stalls

    {:ok, assign(socket,
        my_plugins: [],
        businesses: businesses,
        # my_stalls: Marketplace.list_stalls_for_business(),
        # my_stalls: stalls,
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
    # |> assign(:advertisement, Marketplace.get_advertisement!(id))
  end

  defp apply_action(socket, :index, %{}) do
    socket
    |> assign(:page_title, "Edit config")
    # |> assign(:advertisement, Marketplace.get_advertisement!(id))
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
    products = Marketplace.list_products_of_business()
    # stall = Marketplace.get_stall!(stall_id)
    stall = Marketplace.get_stall_detail!(stall_id)

    socket
    |> assign(:page_title, "Edit Stall")
    |> assign(:products, products)
    |> assign(:stall, stall)
  end

  defp apply_action(socket, :new_business, _params) do
    cities = Atmanirbhar.Geo.list_cities()

    socket
    |> assign(:page_title, "List your business")
    |> assign(:business, %Business{})
    |> assign(:cities, cities)
  end
  defp apply_action(socket, :new_advertisement, _params) do
    socket
    |> assign(:page_title, "Add your deal in this region")
    |> assign(:advertisement, %Advertisement{})
  end
  defp apply_action(socket, :new_deal, _params) do
    socket
    |> assign(:page_title, "Add your deal in this region")
    |> assign(:deal, %Deal{})
  end







  def handle_event("recover_wizard", params, socket) do
    # rebuild state based on client input data up to the current step
    IO.puts "---------- recover wizaer "
    {:noreply, socket}
  end





end
