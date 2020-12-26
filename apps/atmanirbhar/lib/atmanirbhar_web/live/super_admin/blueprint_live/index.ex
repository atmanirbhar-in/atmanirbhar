defmodule AtmanirbharWeb.BlueprintLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Catalog
  alias Atmanirbhar.Catalog.Blueprint

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :catalog_blueprints, list_catalog_blueprints())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Blueprint")
    |> assign(:blueprint, Catalog.get_blueprint!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Blueprint")
    |> assign(:blueprint, %Blueprint{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Catalog blueprints")
    |> assign(:blueprint, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    blueprint = Catalog.get_blueprint!(id)
    {:ok, _} = Catalog.delete_blueprint(blueprint)

    {:noreply, assign(socket, :catalog_blueprints, list_catalog_blueprints())}
  end

  defp list_catalog_blueprints do
    Catalog.list_catalog_blueprints()
  end
end
