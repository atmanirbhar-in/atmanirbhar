defmodule AtmanirbharWeb.UserDashboardStallLive.Index do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.{Advertisement, Deal, Business, StallElement, Stall}
  alias Atmanirbhar.Marketplace

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket,
        my_plugins: [],
      )
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new_stall, _params) do
    socket
    |> assign(:page_title, "create new stall")
    |> assign(:stall, %Stall{})
  end
  defp apply_action(socket, :edit_stall, %{"stall_id" => input_stall_id}) do
    {stall_id, _} = Integer.parse(input_stall_id)
    products = Marketplace.list_products_of_business()
    # stall = Marketplace.get_stall!(stall_id)
    stall = Marketplace.get_stall_detail!(stall_id)

    socket
    |> assign(:page_title, "Edit Stall")
    |> assign(:products, products)
    |> assign(:stall, stall)
  end

  def handle_event("add-card-to-stall",
    %{"drag_card_id" => element_id, "drag_card_type" => element_type}, socket) do
    IO.puts "add card to stall"
    # save_stall(socket, socket.assigns.action, stall_params)
    # Marketplace.add_element_to_stall()
    # assign(socket, :changeset, changeset)
    {:noreply, socket}
  end

  def handle_event("recover_wizard", params, socket) do
    # rebuild state based on client input data up to the current step
    IO.puts "---------- recover wizaer "
    {:noreply, socket}
  end
end
