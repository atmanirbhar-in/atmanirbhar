defmodule AtmanirbharWeb.ShopLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace

  @impl true
  def update(%{shop: shop} = assigns, socket) do
    changeset = Marketplace.change_shop(shop)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"shop" => shop_params}, socket) do
    changeset =
      socket.assigns.shop
      |> Marketplace.change_shop(shop_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"shop" => shop_params}, socket) do
    save_shop(socket, socket.assigns.action, shop_params)
  end

  defp save_shop(socket, :edit, shop_params) do
    case Marketplace.update_shop(socket.assigns.shop, shop_params) do
      {:ok, _shop} ->
        {:noreply,
         socket
         |> put_flash(:info, "Shop updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_shop(socket, :new, shop_params) do
    case Marketplace.create_shop(shop_params) do
      {:ok, _shop} ->
        {:noreply,
         socket
         |> put_flash(:info, "Shop created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
