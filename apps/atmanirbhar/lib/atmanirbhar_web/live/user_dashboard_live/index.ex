defmodule AtmanirbharWeb.UserDashboardLive.Index do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.{Advertisement, Deal, Business}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket,
        my_plugins: []
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

  # defp apply_action(socket, :new_ad, _params) do
  #   socket
  #   |> assign(:page_title, "New Advertisement")
  #   |> assign(:advertisement, %Advertisement{})
  # end

  defp apply_action(socket, :new_business, _params) do
    socket
    |> assign(:page_title, "List your business")
    |> assign(:business, %Business{})
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
