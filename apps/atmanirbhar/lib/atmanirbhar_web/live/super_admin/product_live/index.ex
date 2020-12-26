defmodule AtmanirbharWeb.ProductLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.Product

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :marketplace_products, list_marketplace_products())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Marketplace.get_product!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Marketplace products")
    |> assign(:product, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Marketplace.get_product!(id)
    {:ok, _} = Marketplace.delete_product(product)

    {:noreply, assign(socket, :marketplace_products, list_marketplace_products())}
  end

  defp list_marketplace_products do
    Marketplace.list_marketplace_products()
  end
end
