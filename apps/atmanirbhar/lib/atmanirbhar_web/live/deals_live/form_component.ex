defmodule AtmanirbharWeb.DealsLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace

  @impl true
  def update(%{deals: deals} = assigns, socket) do
    changeset = Marketplace.change_deals(deals)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"deals" => deals_params}, socket) do
    changeset =
      socket.assigns.deals
      |> Marketplace.change_deals(deals_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"deals" => deals_params}, socket) do
    save_deals(socket, socket.assigns.action, deals_params)
  end

  defp save_deals(socket, :edit, deals_params) do
    case Marketplace.update_deals(socket.assigns.deals, deals_params) do
      {:ok, _deals} ->
        {:noreply,
         socket
         |> put_flash(:info, "Deals updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_deals(socket, :new, deals_params) do
    case Marketplace.create_deals(deals_params) do
      {:ok, _deals} ->
        {:noreply,
         socket
         |> put_flash(:info, "Deals created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
