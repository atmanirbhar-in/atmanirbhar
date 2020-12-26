defmodule AtmanirbharWeb.TaxonomyLive.Show do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Catalog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:taxonomy, Catalog.get_taxonomy!(id))}
  end

  defp page_title(:show), do: "Show Taxonomy"
  defp page_title(:edit), do: "Edit Taxonomy"
end
