defmodule Atmanirbhar.Checkout do
  alias Atmanirbhar.Checkout.{Order, Basket, BasketItem}
  alias Atmanirbhar.Marketplace.{Business}
  alias Atmanirbhar.Catalog.Product

  import Ecto.Query, warn: false
  import Ecto.Changeset, warn: false
  alias Atmanirbhar.Repo

  # def add_to_cart(product, customer, business) do
  # end

  # defdelegate add_to_basket(product, basket, business), to: Basket, as: :add

  def add_to_basket(product_id, customer_basket_id, business_id) do
    # IO.puts "checkout/ add-to-basket - product #{product_id} - business - #{business_id}"

    basket =
      customer_basket_id
      |> get_basket()

    {int_prod_id, _} = Integer.parse(product_id)

    attrs = %{
      product_id: int_prod_id,
      business_id: business_id,
      quantity: 1
    }

    IO.puts inspect(basket)
    IO.puts "basket ^^^^"

    build_basket_item = Ecto.build_assoc(basket, :basket_items, attrs)

    build_basket_item
    |> BasketItem.changeset(attrs)
    |> Repo.insert!
  end

  def remove_from_cart(product, customer_basket, business) do
  end

  def get_basket(basket_id) do
    Repo.get!(Basket, basket_id)
  end

  def create_basket() do
    %Basket{}
    |> Basket.changeset(%{is_guest: true})
    |> Repo.insert()
  end



end
