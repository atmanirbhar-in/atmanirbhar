defmodule AtmanirbharWeb.PageLive do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.{Advertisement, Deal, LocationForm, StallFiltersForm}
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

    stall_filters_form = %StallFiltersForm{}
    stall_filters_changeset = Marketplace.change_stall_filters_form(stall_filters_form)

    if connected?(socket) do
      Marketplace.subscribe(pincode)
    end

    topic = "marketplace:#{pincode}"
    initial_count = Presence.list(topic) |> map_size

    # Track changes to the topic
    Presence.track(
      self(),
      topic,
      socket.id,
      %{}
    )

    deals = Atmanirbhar.Marketplace.list_deals_for_pincode(pincode)
    # shops = Atmanirbhar.Marketplace.list_shops()
    shops = []
    # advertisements = Atmanirbhar.Marketplace.list_advertisements()
    advertisements = []

    socket = socket
    |> assign(:page_title, "Packages")
    |> assign(location_form: location_form)
    |> assign(pincode_changeset: pincode_changeset)
    |> assign(stall_filters_form: stall_filters_form)
    |> assign(stall_filters_changeset: stall_filters_changeset)
    |> assign(reader_count: initial_count)
    |> assign(deals: deals)
    |> assign(advertisements: advertisements)
    |> assign(shops: shops)

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
    {:noreply, assign(socket, results: search(query), query: query)}
  end

  def handle_params(params, url, socket) do
    host_name =  URI.parse(url).host
    Atmanirbhar.Repo.put_org_id(host_name)
    # IO.puts "^^^^^^^^^^^^^^^^^^"
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("validate-location-form", %{"location_form" => form_params}, socket) do
    # pincode_changeset = Marketplace.change_location_form(%LocationForm{})
    # IO.puts inspect(form_params)
    # IO.puts "check location form params"

    changeset =
      socket.assigns.location_form
      |> Marketplace.change_location_form(form_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :pincode_changeset, changeset)}
  end

  @impl true
  def handle_event("set-pincode", %{"location_form" => form_params}, socket) do
    # IO.puts "form params"
    # IO.puts inspect(form_params)
    %{"pincode" => pincode} = form_params
    {:noreply, push_redirect(socket, to: "/pincode/#{pincode}")}
  end


  @impl true
  def handle_event("change-stall-filters", %{"stall_filters_form" => form_params}, socket) do
    %{"show_male" => show_male,
      "show_female" => show_female
    } = form_params
    stalls = Atmanirbhar.Marketplace.list_stalls_with_filters(%{
          show_male: to_bool(show_male),
          show_female: to_bool(show_female)
                                                              })
    # IO.puts "--------------"
    # IO.puts "change filter params"
    # IO.puts inspect(form_params)
    # %{"pincode" => pincode} = form_params
    # stall_filters_changeset = %StallFiltersForm{form_params}
    stall_filters_form = %StallFiltersForm{
      show_male: to_bool(show_male),
      show_female: to_bool(show_female)
    }
    stall_filters_changeset = Marketplace.change_stall_filters_form(stall_filters_form)

    socket = socket
    |> assign(:stalls, stalls)
    |> assign(stall_filters_changeset: stall_filters_changeset)

    {:noreply, socket}
  end

  defp to_bool("true"), do: true
  defp to_bool("false"), do: false


  @impl true
  # fetch marketplace data for new pincode
  def handle_event("updated_session_data", ["pincode", new_pincode], socket) do
    # if connected?(socket), do: Marketplace.subscribe
    # unsubscribe(pubsub, topic)
    old_pincode = socket.assigns.pincode
    Phoenix.PubSub.unsubscribe(Atmanirbhar.PubSub, "marketplace:#{old_pincode}")
    Marketplace.subscribe(new_pincode)

    deals = Atmanirbhar.Marketplace.list_deals_for_pincode(new_pincode)
    # {:noreply, update(socket, :pincode, fn _old_pincode -> new_pincode end )}
    # {:noreply, update(socket, :deals, fn _ -> deals end)}
    {:noreply, assign(socket, deals: deals, pincode: new_pincode)}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      %{^query => vsn} ->
        {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
         |> assign(results: %{}, query: query)}
    end
  end

  @impl true
  def handle_info({:deal_created, deal}, socket) do
    {:noreply, update(socket, :deals, fn deals -> [deal | deals] end)}
  end

  defp search(query) do
    if not AtmanirbharWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    for {app, desc, vsn} <- Application.started_applications(),
        app = to_string(app),
        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
        into: %{},
        do: {app, vsn}
  end

  def handle_info(
    %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
    %{assigns: %{reader_count: count}} = socket
  ) do
    reader_count = count + map_size(joins) - map_size(leaves)

    {:noreply, assign(socket, :reader_count, reader_count)}
  end

  defp apply_action(socket, :pincode, params) do
    pincode = params["pincode"] |> String.to_integer
    socket
    |> assign(:pincode, pincode)
  end
  defp apply_action(socket, :index, _params) do
    stalls = Marketplace.list_marketplace_stalls()

    socket
    |> assign(:page_title, "Micro businesses in this region")
    |> assign(:stalls, stalls)
  end

  defp apply_action(socket, :new_deal, _params) do
    socket
    |> assign(:page_title, "Add your deal in this region")
    |> assign(:deal, %Deal{})
  end
  defp apply_action(socket, :new_advertisement, _params) do
    socket
    |> assign(:page_title, "Add your Advertisement in this region")
    |> assign(:advertisement, %Advertisement{})
  end

end
