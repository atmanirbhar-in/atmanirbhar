defmodule AtmanirbharWeb.TaxonomyLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Catalog

  @impl true
  def update(%{taxonomy: taxonomy} = assigns, socket) do
    changeset = Catalog.change_taxonomy(taxonomy)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"taxonomy" => taxonomy_params}, socket) do
    changeset =
      socket.assigns.taxonomy
      |> Catalog.change_taxonomy(taxonomy_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"taxonomy" => taxonomy_params}, socket) do
    save_taxonomy(socket, socket.assigns.action, taxonomy_params)
  end

  defp save_taxonomy(socket, :edit, taxonomy_params) do
    case Catalog.update_taxonomy(socket.assigns.taxonomy, taxonomy_params) do
      {:ok, _taxonomy} ->
        {:noreply,
         socket
         |> put_flash(:info, "Taxonomy updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_taxonomy(socket, :new, taxonomy_params) do
    case Catalog.create_taxonomy(taxonomy_params) do
      {:ok, _taxonomy} ->
        {:noreply,
         socket
         |> put_flash(:info, "Taxonomy created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
