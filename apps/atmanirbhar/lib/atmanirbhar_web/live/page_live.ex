defmodule AtmanirbharWeb.PageLive do
  use AtmanirbharWeb, :live_view

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.{Advertisement, Deal, LocationForm, StallFilters}
  alias Atmanirbhar.Presence

  @impl true
  # def mount(params, %{"locale" => locale}, socket) do
  def mount(params, session, socket) do

    pincode = params["pincode"] || 12345
    location_form = %LocationForm{pincode: pincode}
    pincode_changeset = Marketplace.change_location_form(location_form)


    # topic = "marketplace:#{pincode}"
    # initial_count = Presence.list(topic) |> map_size

    # # Track changes to the topic
    # Presence.track(
    #   self(),
    #   topic,
    #   socket.id,
    #   %{}
    # )

    stall_filters = Marketplace.change_stall_filters(%StallFilters{}, params)
    |> Ecto.Changeset.apply_changes

    stalls = Atmanirbhar.Marketplace.list_stalls_with_filters(stall_filters)
    changeset = Marketplace.change_stall_filters(stall_filters)

    socket = socket
    |> assign(:stalls, stalls)
    |> assign(stall_filters_changeset: changeset)
    |> assign(:page_title, "Micro businesses in this region")
    {:ok, socket}
  end

  def handle_params(params, url, socket) do
    # host_name =  URI.parse(url).host
    # Atmanirbhar.Repo.put_org_id(host_name)
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
    %{"pincode" => pincode} = form_params
    {:noreply, push_redirect(socket, to: "/pincode/#{pincode}")}
  end


  @impl true
  def handle_event("change-stall-filters", %{"stall_filters" => form_params}, socket) do
    stall_changeset = Marketplace.change_stall_filters(%StallFilters{}, form_params)
    stall_filters = stall_changeset
    |> Ecto.Changeset.apply_changes

    stalls = Atmanirbhar.Marketplace.list_stalls_with_filters(stall_filters)

    socket = socket
    |> assign(:stalls, stalls)
    |> assign(stall_filters_changeset: stall_changeset)
    {:noreply, socket}
  end

  @impl true
  # fetch marketplace data for new pincode
  def handle_event("updated_session_data", ["pincode", new_pincode], socket) do
    old_pincode = socket.assigns.pincode
    # Phoenix.PubSub.unsubscribe(Atmanirbhar.PubSub, "marketplace:#{old_pincode}")
    # Marketplace.subscribe(new_pincode)

    # deals = Atmanirbhar.Marketplace.list_deals_for_pincode(new_pincode)
    # {:noreply, update(socket, :pincode, fn _old_pincode -> new_pincode end )}
    # {:noreply, update(socket, :deals, fn _ -> deals end)}
    # {:noreply, assign(socket, deals: deals, pincode: new_pincode)}
    {:noreply, socket}
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

  defp apply_action(socket, :index, params) do
    stall_filters = Marketplace.change_stall_filters(%StallFilters{}, params)
    |> Ecto.Changeset.apply_changes

    stalls = Atmanirbhar.Marketplace.list_stalls_with_filters(stall_filters)
    changeset = Marketplace.change_stall_filters(stall_filters)

    socket = socket
    |> assign(:stalls, stalls)
    |> assign(stall_filters_changeset: changeset)
    |> assign(:page_title, "Micro businesses in this region")
  end

  # defp apply_action(socket, :new_deal, _params) do
  #   socket
  #   |> assign(:page_title, "Add your deal in this region")
  #   |> assign(:deal, %Deal{})
  # end
  # defp apply_action(socket, :new_advertisement, _params) do
  #   socket
  #   |> assign(:page_title, "Add your Advertisement in this region")
  #   |> assign(:advertisement, %Advertisement{})
  # end

end
