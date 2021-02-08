defmodule AtmanirbharWeb.UserDashboardLive.Catalog do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Catalog
  alias Atmanirbhar.Catalog.Product

  def mount(params, session, socket) do
    socket =
      socket
      |> MountHelpers.assign_defaults(params, session, [:upload_pictures, :view_gallery])

    {
      :ok,
      socket
      |> assign(:products, socket.assigns.current_business.products)
    }
  end

  # def handle_event("validate", %{"product" => product_params}, socket) do
  #   changeset = socket.assigns.product
  #   |> Catalog.change_product(product_params)
  #   |> Map.put(:action, :validate)
  #   {:noreply, assign(socket, :changeset, changeset)}
  # end

  def handle_params(_params, _url, socket) do
    {
      :noreply,
      apply_action(socket, socket.assigns.live_action, %{})
    }
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "My Products")
  end

  defp apply_action(socket, :new_product, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end
end
