defmodule Atmanirbhar.Checkout do
  alias Atmanirbhar.Checkout.Order

  # def add_to_cart(product, customer, business) do
  # end

  defdelegate add_to_cart(product, customer, business), to: Order, as: :add

  def remove_from_cart(product, customer, business) do
  end

end
