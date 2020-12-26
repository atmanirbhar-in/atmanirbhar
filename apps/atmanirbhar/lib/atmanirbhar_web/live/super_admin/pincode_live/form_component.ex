defmodule AtmanirbharWeb.PincodeLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Geo

  @impl true
  def update(%{pincode: pincode} = assigns, socket) do
    changeset = Geo.change_pincode(pincode)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"pincode" => pincode_params}, socket) do
    changeset =
      socket.assigns.pincode
      |> Geo.change_pincode(pincode_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"pincode" => pincode_params}, socket) do
    save_pincode(socket, socket.assigns.action, pincode_params)
  end

  defp save_pincode(socket, :edit, pincode_params) do
    case Geo.update_pincode(socket.assigns.pincode, pincode_params) do
      {:ok, _pincode} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pincode updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_pincode(socket, :new, pincode_params) do
    case Geo.create_pincode(pincode_params) do
      {:ok, _pincode} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pincode created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
