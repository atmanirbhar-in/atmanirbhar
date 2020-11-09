defmodule AtmanirbharWeb.DealsLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.Deals

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :marketplace_products_deals, list_marketplace_products_deals())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Deals")
    |> assign(:deals, Marketplace.get_deals!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Deals")
    |> assign(:deals, %Deals{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Marketplace products deals")
    |> assign(:deals, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    deals = Marketplace.get_deals!(id)
    {:ok, _} = Marketplace.delete_deals(deals)

    {:noreply, assign(socket, :marketplace_products_deals, list_marketplace_products_deals())}
  end

  defp list_marketplace_products_deals do
    Marketplace.list_marketplace_products_deals()
  end
end
