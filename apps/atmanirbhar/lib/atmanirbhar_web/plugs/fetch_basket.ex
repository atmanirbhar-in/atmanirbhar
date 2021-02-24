defmodule AtmanirbharWeb.Plugs.FetchBasket do
  import Plug.Conn
  alias Atmanirbhar.Checkout.Basket
  alias Atmanirbhar.Checkout

  def init(_opts), do: nil

  def call(conn, _) do
    with basket_id <- get_session(conn, :basket_id),
         true <- is_integer(basket_id),
           %Basket{} = basket <- Checkout.get_basket(basket_id) do
      conn
      |> assign(:basket, basket)
    else
      _ ->
        {:ok, basket} = Checkout.create_basket()
      # guest session or signed-in user

      conn
      |> put_session(:basket_id, basket.id)
      |> assign(:basket, basket)
    end
  end
end
