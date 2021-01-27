defmodule AtmanirbharWeb.UserDashboardLive.Catalog do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Catalog
  alias Atmanirbhar.Catalog.Product

  def mount(%{"business_id" => business_id} = params, session, socket) do
    socket = socket
    |> assign(products: Marketplace.list_business_products(business_id))
    |> assign(:business_id, business_id)

    {:ok, socket}
  end

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
