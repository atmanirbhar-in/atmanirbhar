defmodule AtmanirbharWeb.RawMaterialLive.Index do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Resources
  alias Atmanirbhar.Resources.RawMaterial

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :raw_materials, list_raw_materials())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Raw material")
    |> assign(:raw_material, Resources.get_raw_material!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Raw material")
    |> assign(:raw_material, %RawMaterial{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Raw Materials at Wholesale price. Bakery, Fashion, Tailor, small Business in India")
    |> assign(:raw_material, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    raw_material = Resources.get_raw_material!(id)
    {:ok, _} = Resources.delete_raw_material(raw_material)

    {:noreply, assign(socket, :raw_materials, list_raw_materials())}
  end

  defp list_raw_materials do
    Resources.list_raw_materials()
  end
end
