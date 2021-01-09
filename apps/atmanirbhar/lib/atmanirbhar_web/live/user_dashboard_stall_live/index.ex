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
    stall_elements_groups = stall.stall_elements
    |> Enum.group_by(&Map.get(&1, :type))

    socket
    |> assign(:page_title, "Edit Stall")
    |> assign(:products, products)
    |> assign(:stall, stall)
    |> assign(:stall_elements_groups, stall_elements_groups)
  end

  def handle_event("remove-card-from-stall", %{"card" => element_id}, socket) do
    stall = socket.assigns.stall
    {stall_element_id, _} = String.trim_leading(element_id, "card-") |> Integer.parse
    # IO.puts "remove stall element - #{stall_element_id}"
    case Marketplace.remove_stall_element_from_stall(stall_element_id, stall) do
      {:ok, stall} ->

        send(self(), :reload_stall_elements)

        # updated_stall = Marketplace.get_stall_detail!(stall.id)

        # IO.puts "stall inspect..."
        # # IO.puts inspect(updated_stall)

        # stall_elements_groups = updated_stall.stall_elements
        # |> Enum.group_by(&Map.get(&1, :type))

        # IO.puts Enum.count(stall.stall_elements)

        # {:noreply,
        #  socket
        #  |> assign(:stall, updated_stall)
        #  |> assign(:stall_elements_groups, stall_elements_groups)
        # }

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def handle_info(:reload_stall_elements, socket) do
    updated_stall = Marketplace.get_stall_detail!(socket.assigns.stall.id)

    stall_elements_groups = updated_stall.stall_elements
    |> Enum.group_by(&Map.get(&1, :type))

    # IO.puts Enum.count(stall.stall_elements)

    {:noreply,
     socket
     |> assign(:stall, updated_stall)
     |> assign(:stall_elements_groups, stall_elements_groups)
    }
  end

  def handle_event("add-card-to-stall",
    %{"drag_card_id" => element_id, "drag_card_type" => element_type}, socket) do
    IO.puts "add card to stall ----  #{element_id}"
    stall = socket.assigns.stall
    {stall_element_id, _} = String.trim_leading(element_id, "card-") |> Integer.parse

      # Marketplace.add_stall_element_to_stall(element_id, stall_id)

    case Marketplace.add_stall_element_to_stall(stall_element_id, stall) do
      {:ok, stall} ->

        stall_elements_groups = stall.stall_elements
        |> Enum.group_by(&Map.get(&1, :type))

        {:noreply,
         socket
         |> assign(:stall, stall)
         |> assign(:stall_elements_groups, stall_elements_groups)
        }
        # {:noreply,
        #  socket
        #  |> put_flash(:info, "Product updated successfully")
        # |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
    # save_stall(socket, socket.assigns.action, stall_params)
    # Marketplace.add_element_to_stall()
    # assign(socket, :changeset, changeset)
  end

  def handle_event("recover_wizard", params, socket) do
    # rebuild state based on client input data up to the current step
    IO.puts "---------- recover wizaer "
    {:noreply, socket}
  end
end
