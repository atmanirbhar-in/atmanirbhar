defmodule AtmanirbharWeb.PincodeLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Geo
  alias Atmanirbhar.Geo.Pincode

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :pincodes, list_pincodes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pincode")
    |> assign(:pincode, Geo.get_pincode!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pincode")
    |> assign(:pincode, %Pincode{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pincodes")
    |> assign(:pincode, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pincode = Geo.get_pincode!(id)
    {:ok, _} = Geo.delete_pincode(pincode)

    {:noreply, assign(socket, :pincodes, list_pincodes())}
  end

  defp list_pincodes do
    Geo.list_pincodes()
  end
end
