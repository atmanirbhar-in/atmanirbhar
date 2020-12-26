defmodule AtmanirbharWeb.UserDashboardLive.StallMediaComponent do
  use AtmanirbharWeb, :live_component
  alias Atmanirbhar.Marketplace.{Business, GalleryItem, Stall}
  alias Atmanirbhar.Marketplace


  @impl true
  def update(%{stall_id: stall_id} = assigns, socket) do

    products = Marketplace.list_all_gallery_items_of_business()
    stall = Marketplace.get_stall_detail!(stall_id)
    gallery_items_groups = stall.gallery_items
    |> Enum.group_by(&Map.get(&1, :type))

    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(:page_title, "Edit Stall")
      |> assign(:stall_id, stall_id)
      |> assign(:products, products)
      |> assign(:stall, stall)
      |> assign(:gallery_items_groups, gallery_items_groups)
    }
  end

  def handle_event("remove-card-from-stall", %{"card" => element_id}, socket) do
    stall = socket.assigns.stall
    {gallery_item_id, _} = String.trim_leading(element_id, "card-") |> Integer.parse
    case Marketplace.remove_gallery_item_from_stall(gallery_item_id, stall) do
      {:ok, stall} ->
        updated_stall = Marketplace.get_stall_detail!(stall.id)

        gallery_items_groups = updated_stall.gallery_items
        |> Enum.group_by(&Map.get(&1, :type))

        {:noreply,
         socket
         |> assign(:stall, updated_stall)
         |> assign(:gallery_items_groups, gallery_items_groups)
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def handle_event("add-card-to-stall",
    %{"drag_card_id" => element_id, "drag_card_type" => element_type}, socket) do
    stall = socket.assigns.stall
    {gallery_item_id, _} = String.trim_leading(element_id, "card-") |> Integer.parse

    case Marketplace.add_gallery_item_to_stall(gallery_item_id, stall) do
      {:ok, stall} ->

        gallery_items_groups = stall.gallery_items
        |> Enum.group_by(&Map.get(&1, :type))

        {:noreply,
         socket
         |> assign(:stall, stall)
         |> assign(:gallery_items_groups, gallery_items_groups)
        }
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def handle_event("recover_wizard", params, socket) do
    # rebuild state based on client input data up to the current step
    IO.puts "---------- recover wizaer "
    {:noreply, socket}
  end

end
