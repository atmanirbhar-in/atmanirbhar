defmodule AtmanirbharWeb.BlueprintLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Catalog

  @impl true
  def update(%{blueprint: blueprint} = assigns, socket) do
    changeset = Catalog.change_blueprint(blueprint)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"blueprint" => blueprint_params}, socket) do
    changeset =
      socket.assigns.blueprint
      |> Catalog.change_blueprint(blueprint_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"blueprint" => blueprint_params}, socket) do
    save_blueprint(socket, socket.assigns.action, blueprint_params)
  end

  defp save_blueprint(socket, :edit, blueprint_params) do
    case Catalog.update_blueprint(socket.assigns.blueprint, blueprint_params) do
      {:ok, _blueprint} ->
        {:noreply,
         socket
         |> put_flash(:info, "Blueprint updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_blueprint(socket, :new, blueprint_params) do
    case Catalog.create_blueprint(blueprint_params) do
      {:ok, _blueprint} ->
        {:noreply,
         socket
         |> put_flash(:info, "Blueprint created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
