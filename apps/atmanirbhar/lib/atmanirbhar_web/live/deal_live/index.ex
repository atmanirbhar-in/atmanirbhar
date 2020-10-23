defmodule AtmanirbharWeb.DealLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.Deal

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :deals, list_deals())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Deal")
    |> assign(:deal, Marketplace.get_deal!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Deal")
    |> assign(:deal, %Deal{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Deals")
    |> assign(:deal, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    deal = Marketplace.get_deal!(id)
    {:ok, _} = Marketplace.delete_deal(deal)

    {:noreply, assign(socket, :deals, list_deals())}
  end

  defp list_deals do
    Marketplace.list_deals()
  end
end
