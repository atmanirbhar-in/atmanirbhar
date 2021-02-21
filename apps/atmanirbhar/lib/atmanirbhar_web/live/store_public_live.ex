defmodule AtmanirbharWeb.StorePublicLive do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace

  @impl true
  def mount(params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, %{"store_id" => store_id}) do
    business = Marketplace.get_business!(store_id)
    # business = Atmanirbhar.Marketplace.load_business!(store_id)

    products = Marketplace.list_business_products(business)
    medias = Marketplace.list_business_medias(business)
    # # cart = []

    socket
    |> assign(:business, business)
    |> assign(:products, products)
    |> assign(:medias, medias)
  end

  # def handle_event("add-product", socket) do
  # end

end
