defmodule AtmanirbharWeb.DealLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace

  @impl true
  def update(%{deal: deal} = assigns, socket) do
    changeset = Marketplace.change_deal(deal)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"deal" => deal_params}, socket) do
    changeset =
      socket.assigns.deal
      |> Marketplace.change_deal(deal_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"deal" => deal_params}, socket) do
    save_deal(socket, socket.assigns.action, deal_params)
  end

  defp save_deal(socket, :edit, deal_params) do
    case Marketplace.update_deal(socket.assigns.deal, deal_params) do
      {:ok, _deal} ->
        {:noreply,
         socket
         |> put_flash(:info, "Deal updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end


  defp save_deal(socket, :new_deal, deal_params), do: save_deal(socket, :new, deal_params)
  defp save_deal(socket, :new, deal_params) do
    case Marketplace.create_deal(deal_params) do
      {:ok, _deal} ->
        {:noreply,
         socket
         |> put_flash(:info, "Deal created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
