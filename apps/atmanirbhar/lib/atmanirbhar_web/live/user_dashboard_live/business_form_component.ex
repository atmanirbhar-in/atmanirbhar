defmodule AtmanirbharWeb.UserDashboardLive.BusinessFormComponent do
  use AtmanirbharWeb, :live_component

  @impl true
  def update(%{business: business} = assigns, socket) do
    changeset = Atmanirbhar.Marketplace.change_business(business)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

end
