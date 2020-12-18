defmodule AtmanirbharWeb.StallLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace

  @impl true
  def update(%{stall: stall} = assigns, socket) do
    changeset = Marketplace.change_stall(stall)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"stall" => stall_params}, socket) do
    changeset =
      socket.assigns.stall
      |> Marketplace.change_stall(stall_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"stall" => stall_params}, socket) do
    save_stall(socket, socket.assigns.action, stall_params)
  end

  defp save_stall(socket, :edit, stall_params) do
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

  defp save_stall(socket, :new, stall_params) do
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
