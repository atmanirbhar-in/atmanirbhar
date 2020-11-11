defmodule AtmanirbharWeb.UserDashboardLive.BusinessFormComponent do
  use AtmanirbharWeb, :live_component

  @impl true
  def update(%{business: business} = assigns, socket) do
    changeset = Atmanirbhar.Marketplace.change_business(business)
    cities = Atmanirbhar.Geo.list_only_cities()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:cities, cities)
     |> assign(:areas, [])
    }
  end

end
