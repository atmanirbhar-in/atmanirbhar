defmodule AtmanirbharWeb.AdvertisementLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace

  @impl true
  def update(%{advertisement: advertisement} = assigns, socket) do
    changeset = Marketplace.change_advertisement(advertisement)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"advertisement" => advertisement_params}, socket) do
    changeset =
      socket.assigns.advertisement
      |> Marketplace.change_advertisement(advertisement_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"advertisement" => advertisement_params}, socket) do
    save_advertisement(socket, socket.assigns.action, advertisement_params)
  end

  defp save_advertisement(socket, :edit, advertisement_params) do
    case Marketplace.update_advertisement(socket.assigns.advertisement, advertisement_params) do
      {:ok, _advertisement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Advertisement updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_advertisement(socket, :new_ad, advertisement_params) do
    case Marketplace.create_advertisement(advertisement_params) do
      {:ok, _advertisement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Advertisement created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp save_advertisement(socket, :new_advertisement, advertisement_params), do: save_advertisement(socket, :new, advertisement_params)
  defp save_advertisement(socket, :new, advertisement_params) do
    case Marketplace.create_advertisement(advertisement_params) do
      {:ok, _advertisement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Advertisement created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
