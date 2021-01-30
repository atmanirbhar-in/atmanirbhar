defmodule AtmanirbharWeb.UserDashboardLive.StallFormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace

  @impl true
  def update(%{stall: stall} = assigns, socket) do
    changeset = Marketplace.change_stall(stall)
    locations = Atmanirbhar.Geo.list_locations() |> Enum.map(&{&1.title, &1.id})
    my_media = assigns.current_business.medias
    my_products = assigns.current_business.products

    socket = socket
    |> assign(assigns)
    |> assign(:locations, locations)
    |> assign(:changeset, changeset)
    |> assign(:all_media, my_media)
    |> assign(:all_products, my_products)
    |> assign(:stall_media_ids,[])
    |> assign(:stall_product_ids,[])

    {:ok,
     socket
     |> assign(:stall_medias, filter_stall_medias(my_media, socket.assigns[:stall_media_ids]))
     |> assign(:stall_products, filter_stall_medias(my_products, socket.assigns[:stall_product_ids]))
    }
  end

  defp stall_products(socket) do
    Enum.filter(socket.assigns.all_products,
      fn obj -> obj.id in socket.assigns.stall_product_ids
      end)
  end
  defp filter_stall_medias(all_media, stall_media_ids) do
    Enum.filter(all_media,
      fn obj -> obj.id in stall_media_ids
      end)
  end
  defp filter_stall_products(all_elements, stall_element_ids) do
    Enum.filter(all_elements,
      fn obj -> obj.id in stall_element_ids
      end)
  end

  @impl true
  def handle_event("validate", %{"stall" => stall_params}, socket) do
    changeset =
      socket.assigns.stall
      |> Marketplace.change_stall(stall_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save_stall", %{"stall" => stall_params}, socket) do
    save_stall(socket, socket.assigns.action, stall_params)
  end

  def handle_event("add-card-to-stall", %{"drag_card_id" => element_id,
                                          "drag_card_type" => "media"
                                         }, socket) do
    {element_item_id, _} = String.trim_leading(element_id, "media-card-") |> Integer.parse

    stall_media_ids = [element_item_id | socket.assigns.stall_media_ids] |> Enum.uniq

    {
      :noreply,
      socket
      |> assign(:stall_media_ids, stall_media_ids)
      |> assign(:stall_medias, filter_stall_medias(socket.assigns[:all_media], stall_media_ids))
    }
  end
  def handle_event("add-card-to-stall", %{"drag_card_id" => element_id,
                                          "drag_card_type" => "product"
                                         }, socket) do
    {element_item_id, _} = String.trim_leading(element_id, "product-card-") |> Integer.parse
    stall_product_ids = [element_item_id | socket.assigns.stall_product_ids] |> Enum.uniq
    {
      :noreply,
      socket
      |> assign(:stall_product_ids, stall_product_ids)
      |> assign(:stall_products, filter_stall_products(socket.assigns[:all_products], stall_product_ids))
    }
  end

  defp save_stall(socket, :edit_stall, stall_params) do
    case Marketplace.update_stall(socket.assigns.stall, stall_params) do
      {:ok, _stall} ->
        {:noreply,
         socket
         |> put_flash(:info, "Stall updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_stall(socket, :new_stall, stall_params) do
    case Marketplace.create_stall(stall_params) do
      {:ok, _stall} ->
        {:noreply,
         socket
         |> put_flash(:info, "Stall created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end



