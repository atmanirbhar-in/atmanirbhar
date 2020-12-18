defmodule AtmanirbharWeb.PageStallLive do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.{Advertisement, Deal, LocationForm}
  alias Atmanirbhar.Presence

  @impl true
  # def mount(params, %{"locale" => locale}, socket) do
  def mount(params, session, socket) do

    # IO.puts inspect(socket)
    # IO.puts "host in socket? -----------------"

    # Atmanirbhar.Repo.put_org_id(123)
    pincode = params["pincode"] || 12345
    location_form = %LocationForm{pincode: pincode}
    pincode_changeset = Marketplace.change_location_form(location_form)

    pictures = [
      "/toys/toys1.jpg",
      "/toys/toys2.jpg",
      "/toys/toys3.jpg",
      "/toys/toys4.jpg",
      "/toys/toys5.jpg",
      "/toys/toys6.jpg",
               ]

    socket = socket
    |> assign(:page_title, "View Stall")
    |> assign(:pictures, pictures)
    |> assign(pincode_changeset: pincode_changeset)

    {:ok, socket}

  end

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) do
    # {:noreply, assign(socket, results: search(query), query: query)}
    {:noreply, socket}
  end

  def handle_params(params, url, socket) do
    host_name =  URI.parse(url).host
    # Atmanirbhar.Repo.put_org_id(host_name)
    # IO.puts "^^^^^^^^^^^^^^^^^^"
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do

    pictures_toys = [
      "/toys/toys2.jpg",
      "/toys/toys8.jpg",
      "/toys/toys7.jpg",
    ]
    pictures_cars = [
      "/toys2/cars2.jpg",
      "/toys2/cars3.jpg",
      "/toys2/cars4.jpg",
    ]
    products = [
      %{
        title: "prod 1",
        description: "mario mario mario mario mario queen queen queen",
        pictures: pictures_toys
      },
      %{
        title: "prod 2",
        description: "cars cars cars cars cars",
        pictures: pictures_cars
      }
    ]
    stall_title = "My Toys store"
    stall_description = "Various Toys for kids.
    They will love them. Cleaned properly, Take home 2 toys at a time.
    I am dentist by profession but this is my passion"

    socket
    |> assign(:page_title, "stall - ")
    |> assign(:stall_title, stall_title)
    |> assign(:stall_description, stall_description)
    |> assign(:products, products)
  end
  defp apply_action(socket, :pincode, params) do
    pincode = params["pincode"] |> String.to_integer
    socket
    |> assign(:page_title, pincode)
  end
end
