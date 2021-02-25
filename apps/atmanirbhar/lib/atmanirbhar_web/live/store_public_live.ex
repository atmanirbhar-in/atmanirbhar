defmodule AtmanirbharWeb.StorePublicLive do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Checkout

  @impl true
  def mount(%{"store_id" => store_id} = params, session, socket) do
    basket_id = session["basket_id"]
    {int_store_id, _} = Integer.parse(store_id)
    # basket_items = Checkout.get_basket_items(basket_id, int_store_id)
    basket_items = Checkout.get_store_basket_items_map(basket_id, int_store_id)

    {:ok,
     socket
     |> assign(:basket_id, basket_id)
     |> assign(:basket_items, basket_items)
     |> assign(:store_id, int_store_id)
    }
  end

  def handle_params(params, url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, %{"store_id" => store_id}) do
    business = Marketplace.get_business!(store_id)
    # business = Atmanirbhar.Marketplace.load_business!(store_id)

    products = Marketplace.list_business_products(business)
    medias = Marketplace.list_business_medias(business)

    socket
    |> assign(:business, business)
    |> assign(:products, products)
    |> assign(:medias, medias)
  end

  def handle_event("add-to-cart", %{"product" => product_id}, socket) do
    basket_id = socket.assigns.basket_id
    store_id = socket.assigns.store_id
    basket_items = socket.assigns.basket_items

    res = Checkout.add_to_basket(product_id, basket_id, store_id)
    {:noreply,
     socket
     |> assign(:basket_items, Map.put(basket_items, res.product_id, res.quantity))
   }
  end

  def handle_event("remove-from-cart", %{"product" => input_product_id}, socket) do
    basket_id = socket.assigns.basket_id
    store_id = socket.assigns.store_id
    basket_items = socket.assigns.basket_items
    product_id = String.to_integer(input_product_id)

    updated_basket_items =
      case Checkout.remove_from_basket(product_id, basket_id, store_id) do
        {1, _ } -> Map.update(basket_items, product_id, 0, &(&1 - 1))
          _ -> basket_items
      end

    {:noreply,
     socket
     |> assign(:basket_items, updated_basket_items)
    }
  end

  def store_menu(socket, assigns) do
    ~L"""

    <%= link to: Routes.customer_cart_path(socket, :cart), class: "btn btn-sm btn-link" do %>
    <span>
    <svg
                    class="h-10 w-10"
                    viewBox="0 0 90.9655 101.37777"
                    height="101.37777mm"
                    width="90.9655mm">
                    <g
                        transform="translate(-38.859516,-56.512502)"
                        id="layer1"
                        inkscape:groupmode="layer"
                        inkscape:label="Layer 1">
    <g
        id="g32"
        transform="matrix(0.35277777,0,0,-0.35277777,85.717265,79.893256)">
        <path
            d="M 0,0 C 0.079,0.509 0.188,0.888 0.188,1.267 0.179,11.656 0.497,22.06 0.044,32.43 c -0.467,10.68 -5.843,18.664 -15.555,23.259 -9.631,4.556 -19.059,3.528 -27.672,-2.638 -7.603,-5.445 -11.138,-13.21 -11.228,-22.492 -0.091,-9.51 -0.027,-19.021 -0.014,-28.531 10e-4,-0.68 0.133,-1.361 0.203,-2.028 z m 105.331,-76.814 c -3.63,0.553 -104.791,0.381 -106.637,-0.181 -3.798,-45.217 -7.601,-90.502 -11.42,-135.958 h 129.494 c -3.821,45.472 -7.625,90.764 -11.437,136.139 M -20.923,-212.947 c 0.138,0.807 0.308,1.498 0.368,2.198 0.657,7.649 1.296,15.299 1.94,22.948 1.432,17.052 2.865,34.104 4.297,51.156 1.772,21.116 3.543,42.232 5.315,63.348 0.303,3.614 1.543,4.777 5.168,4.839 0.72,0.013 1.439,0.004 2.159,0.004 18.96,0 37.92,-0.002 56.88,0.006 0.927,0 1.855,0.085 2.991,0.14 -1.692,20.154 -3.362,40.037 -5.025,59.84 -0.505,0.154 -0.731,0.283 -0.956,0.283 -52.479,0.021 -104.958,0.034 -157.437,0.04 -0.555,0 -1.111,-0.086 -1.665,-0.144 -0.067,-0.007 -0.128,-0.087 -0.188,-0.137 -0.062,-0.051 -0.12,-0.106 -0.18,-0.159 -1.337,-9.208 -17.293,-202.25 -16.863,-204.362 z M -62.326,-0.151 c 0,1.262 -10e-4,2.2 0,3.138 0,9.116 0.027,18.232 -0.007,27.348 -0.028,7.665 1.999,14.698 6.407,20.98 8.953,12.759 24.985,18.024 39.953,13.186 C -2.856,60.262 6.833,48.048 7.942,34.312 8.09,32.481 8.158,30.639 8.163,28.802 8.186,20.166 8.173,11.529 8.173,2.893 V -0.05 c 1.088,-0.037 2.009,-0.096 2.93,-0.097 14.476,-0.006 28.954,-0.004 43.43,-0.004 0.72,0 1.442,0.023 2.159,-0.014 2.406,-0.121 3.736,-1.226 4.034,-3.585 0.339,-2.695 0.532,-5.409 0.76,-8.117 1.271,-15.055 2.535,-30.111 3.798,-45.167 0.247,-2.947 0.469,-5.896 0.718,-8.843 0.066,-0.783 0.192,-1.561 0.325,-2.612 h 2.961 c 12.399,-10e-4 24.796,0 37.193,-10e-4 0.72,0 1.442,0.029 2.159,-0.019 2.722,-0.182 4.078,-1.468 4.31,-4.179 0.829,-9.637 1.631,-19.276 2.444,-28.915 0.866,-10.275 1.735,-20.551 2.599,-30.827 0.892,-10.594 1.778,-21.189 2.668,-31.784 0.878,-10.435 1.762,-20.869 2.639,-31.305 0.556,-6.611 1.109,-13.223 1.652,-19.836 0.059,-0.715 0.115,-1.444 0.046,-2.154 -0.171,-1.734 -1.235,-2.989 -2.949,-3.342 -1.007,-0.208 -2.064,-0.232 -3.098,-0.232 -81.903,-0.01 -163.806,-0.01 -245.711,-0.008 -0.719,0 -1.444,-0.022 -2.157,0.055 -2.667,0.289 -4.034,1.788 -3.899,4.488 0.15,3.032 0.452,6.058 0.703,9.085 0.761,9.162 1.523,18.323 2.299,27.484 0.882,10.435 1.79,20.867 2.669,31.302 0.874,10.356 1.719,20.714 2.589,31.07 0.891,10.594 1.803,21.187 2.695,31.781 0.864,10.276 1.71,20.554 2.572,30.83 0.895,10.674 1.804,21.348 2.703,32.021 0.511,6.055 1.006,12.11 1.528,18.163 0.304,3.527 1.504,4.652 5.016,4.655 14.797,0.012 29.594,0.006 44.392,0.006 z"
            style="fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
            id="path34" />
    </g>
    <g
        id="g60"
        transform="matrix(0.35277777,0,0,-0.35277777,114.42455,120.94054)">
        <path
            d="m 0,0 c 0,-4.876 0.189,-9.761 -0.036,-14.627 -0.647,-13.916 -11.837,-26.528 -27.326,-27.62 -16.397,-1.155 -29.218,10.772 -31.312,24.797 -0.27,1.809 -0.411,3.655 -0.42,5.484 -0.042,8.955 -0.02,17.911 -0.018,26.866 0,0.559 -0.026,1.125 0.047,1.677 0.254,1.955 1.767,3.387 3.667,3.519 1.864,0.13 3.621,-1.121 4.062,-3.024 0.196,-0.843 0.204,-1.742 0.206,-2.616 0.015,-8.875 0.026,-17.75 0.006,-26.626 -0.017,-7.377 2.842,-13.365 8.69,-17.844 12.984,-9.943 32.173,-1.944 34.299,14.28 0.197,1.501 0.292,3.026 0.297,4.54 0.027,8.555 0.013,17.111 0.016,25.667 0.001,0.718 -0.031,1.445 0.059,2.155 0.248,1.949 1.788,3.366 3.696,3.473 1.946,0.108 3.72,-1.303 4.066,-3.319 C 0.133,16.001 0.124,15.19 0.126,14.393 0.137,9.595 0.131,4.797 0.131,0 Z"
            style="fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
            id="path62" />
    </g>
                    </g>
                </svg>


            </span>
        <% end %>

    """
  end

end
