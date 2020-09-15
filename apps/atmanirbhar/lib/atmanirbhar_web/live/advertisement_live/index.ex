defmodule AtmanirbharWeb.AdvertisementLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.Advertisement

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :advertisements, list_advertisements())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Advertisement")
    |> assign(:advertisement, Marketplace.get_advertisement!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Advertisement")
    |> assign(:advertisement, %Advertisement{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Advertisements")
    |> assign(:advertisement, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    advertisement = Marketplace.get_advertisement!(id)
    {:ok, _} = Marketplace.delete_advertisement(advertisement)

    {:noreply, assign(socket, :advertisements, list_advertisements())}
  end

  defp list_advertisements do
    Marketplace.list_advertisements()
  end
end
