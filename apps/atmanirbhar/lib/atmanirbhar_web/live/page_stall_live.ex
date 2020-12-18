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

    pictures = [
      "/toys/toys2.jpg",
      "/toys/toys8.jpg",
      "/toys/toys7.jpg",
    ]

    socket
    |> assign(:page_title, "stall - ")
    |> assign(:pictures, pictures)
  end
  defp apply_action(socket, :pincode, params) do
    pincode = params["pincode"] |> String.to_integer
    socket
    |> assign(:page_title, pincode)
  end
end
