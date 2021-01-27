defmodule AtmanirbharWeb.UserDashboardLive.Catalog do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace

  def mount(%{"business_id" => business_id} = params, session, socket) do
    socket = socket
    |> assign(products: Marketplace.list_business_products(business_id))
    |> assign(:business_id, business_id)

    {:ok, socket}
  end

  # def han do
  # end

end
