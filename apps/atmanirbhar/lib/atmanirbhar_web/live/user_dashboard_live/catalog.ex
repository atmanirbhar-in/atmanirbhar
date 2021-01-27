defmodule AtmanirbharWeb.UserDashboardLive.Catalog do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Catalog
  alias Atmanirbhar.Catalog.Product

  def mount(%{"business_id" => input_business_id} = params, session, socket) do
    {business_id, _} = Integer.parse(input_business_id)

    business = Marketplace.get_business_with_products(business_id)

    socket = socket
    |> assign(products: business.products)
    |> assign(:business_id, business_id)

    {:ok, socket}
  end

  # def handle_event("validate", %{"product" => product_params}, socket) do
  #   changeset = socket.assigns.product
  #   |> Catalog.change_product(product_params)
  #   |> Map.put(:action, :validate)
  #   {:noreply, assign(socket, :changeset, changeset)}
  # end

  def handle_params(_params, _url, socket) do
    {
      :noreply,
      apply_action(socket, socket.assigns.live_action, %{})
    }
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "My Products")
  end

  defp apply_action(socket, :new_product, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

end
