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


    socket = socket
    |> assign(:page_title, "View Stall")
    # |> assign(location_form: location_form)
    # |> assign(pincode_changeset: pincode_changeset)
    # |> assign(reader_count: initial_count)
    # |> assign(deals: deals)
    # |> assign(advertisements: advertisements)
    # |> assign(shops: shops)

    {:ok, socket}

    # assign(socket, %{
    #       query: "",
    #       results: %{},
    #       location_form: location_form,
    #       pincode_changeset: pincode_changeset,
    #       shops: shops,
    #       deals: deals,
    #       reader_count: initial_count,
    #       advertisements: advertisements
    #        }
    # )

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
    socket
    |> assign(:page_title, "stall - ")
  end
  defp apply_action(socket, :pincode, params) do
    pincode = params["pincode"] |> String.to_integer
    socket
    |> assign(:page_title, pincode)
  end
end
