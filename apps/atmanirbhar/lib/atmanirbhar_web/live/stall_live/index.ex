defmodule AtmanirbharWeb.StallLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.Stall

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :marketplace_stalls, list_marketplace_stalls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Stall")
    |> assign(:stall, Marketplace.get_stall!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Stall")
    |> assign(:stall, %Stall{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Marketplace stalls")
    |> assign(:stall, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    stall = Marketplace.get_stall!(id)
    {:ok, _} = Marketplace.delete_stall(stall)

    {:noreply, assign(socket, :marketplace_stalls, list_marketplace_stalls())}
  end

  defp list_marketplace_stalls do
    Marketplace.list_marketplace_stalls()
  end
end
