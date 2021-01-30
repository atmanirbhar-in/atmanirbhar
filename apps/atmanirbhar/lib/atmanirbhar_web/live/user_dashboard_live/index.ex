defmodule AtmanirbharWeb.UserDashboardLive.Index do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.{Business, GalleryItem, Stall}
  alias Atmanirbhar.Marketplace
  alias AtmanirbharWeb.UserDashboardLive.FoldersNavigationComponent

  @impl true
  def mount(params, session, socket) do
    socket = socket
      |> MountHelpers.assign_defaults(params, session, [:create_stall, :upload_pictures])

    todos = [
      %{
        text: "Please add pictures to Gallery",
        cta: "gallery_path"
      }
    ]

    products = socket.assigns.current_business.products

    {:ok,
     assign(socket,
       todos: todos,
       business: socket.assigns.current_business,
       products: products
     )
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp filter_stall_products(all_elements, stall_element_ids) do
    Enum.filter(all_elements,
      fn obj -> obj.id in stall_element_ids
      end)
  end
  def display_stall_product_thumbnails(socket, assigns, stall) do
    product_ids = Map.get(stall.stall_atlas, :product_ids)
    products = filter_stall_products(assigns.products, product_ids)
    ~L"""
    <%= for product <- products do %>
    <img alt="" src="<%= List.first product.images %>" class="w-12 h-12 p-1 m-1" />
    <% end %>
    """
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit config")
  end

  defp apply_action(socket, :index, %{}) do
    socket
    |> assign(:page_title, "My Dashboard - my Businesses and Stalls")
  end

  defp apply_action(socket, :new_stall, _params) do
    socket
    |> assign(:page_title, "create new stall")
    |> assign(:stall, %Stall{})
  end
  defp apply_action(socket, :edit_stall, %{"stall_id" => input_stall_id}) do
    {stall_id, _} = Integer.parse(input_stall_id)
    stall = Marketplace.get_stall_detail!(stall_id)

    socket
    |> assign(:page_title, "Edit Stall")
    |> assign(:stall, stall)
  end

  defp apply_action(socket, :edit_business, %{"business_id" => input_business_id}) do
    cities = Atmanirbhar.Geo.list_cities()
    {business_id, _} = Integer.parse(input_business_id)
    business = Marketplace.get_business!(input_business_id)

    socket
    |> assign(:page_title, "Edit business")
    |> assign(:business, business)
    |> assign(:cities, cities)
  end

  defp apply_action(socket, :new_business, _params) do
    cities = Atmanirbhar.Geo.list_cities()

    socket
    |> assign(:page_title, "List your business")
    |> assign(:business, %Business{})
    |> assign(:cities, cities)
  end

  def handle_event("recover_wizard", params, socket) do
    {:noreply, socket}
  end

end
