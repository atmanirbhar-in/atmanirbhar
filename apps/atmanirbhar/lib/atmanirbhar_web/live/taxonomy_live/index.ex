defmodule AtmanirbharWeb.TaxonomyLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Catalog
  alias Atmanirbhar.Catalog.Taxonomy

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :catalog_taxonomies, list_catalog_taxonomies())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Taxonomy")
    |> assign(:taxonomy, Catalog.get_taxonomy!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Taxonomy")
    |> assign(:taxonomy, %Taxonomy{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Catalog taxonomies")
    |> assign(:taxonomy, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    taxonomy = Catalog.get_taxonomy!(id)
    {:ok, _} = Catalog.delete_taxonomy(taxonomy)

    {:noreply, assign(socket, :catalog_taxonomies, list_catalog_taxonomies())}
  end

  defp list_catalog_taxonomies do
    Catalog.list_catalog_taxonomies()
  end
end
