defmodule AtmanirbharWeb.UserDashboardLive.StallFormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace

  @impl true
  def update(%{stall: stall} = assigns, socket) do
    changeset = Marketplace.change_stall(stall)
    locations = Atmanirbhar.Geo.list_locations() |> Enum.map(&{&1.title, &1.id})
    my_media = assigns.current_business.medias
    my_products = assigns.current_business.products

    # Enum.group_by(arr, &Map.get(&1, :id))
    stall_product_ids = [1]
    stall_products = Enum.filter(my_products,
      fn obj -> obj.id in stall_product_ids end)

    stall_media_ids = [1]
    stall_medias = Enum.filter(my_media,
      fn obj -> obj.id in stall_media_ids end)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:locations, locations)
     |> assign(:changeset, changeset)
     |> assign(:all_media, my_media)
     |> assign(:all_products, my_products)
     |> assign(:stall_products, stall_products)
     |> assign(:stall_medias, stall_medias)
    }
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

  def handle_event("add-gallery-picture-to-stall", %{"drag_card_id" => element_id}, socket) do
    # {gallery_item_id, _} = String.trim_leading(element_id, "card-") |> Integer.parse

    # save_stall(socket, socket.assigns.action, stall_params)
    # Marketplace.add_element_to_stall()
    # assign(socket, :changeset, changeset)
    {:noreply, socket}
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



