defmodule AtmanirbharWeb.RawMaterialLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Resources

  @impl true
  def update(%{raw_material: raw_material} = assigns, socket) do
    changeset = Resources.change_raw_material(raw_material)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"raw_material" => raw_material_params}, socket) do
    changeset =
      socket.assigns.raw_material
      |> Resources.change_raw_material(raw_material_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"raw_material" => raw_material_params}, socket) do
    save_raw_material(socket, socket.assigns.action, raw_material_params)
  end

  defp save_raw_material(socket, :edit, raw_material_params) do
    case Resources.update_raw_material(socket.assigns.raw_material, raw_material_params) do
      {:ok, _raw_material} ->
        {:noreply,
         socket
         |> put_flash(:info, "Raw material updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_raw_material(socket, :new, raw_material_params) do
    case Resources.create_raw_material(raw_material_params) do
      {:ok, _raw_material} ->
        {:noreply,
         socket
         |> put_flash(:info, "Raw material created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
