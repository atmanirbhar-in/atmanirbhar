defmodule Atmanirbhar.Checkout do
  alias Atmanirbhar.Checkout.{Order, Basket, BasketItem}
  alias Atmanirbhar.Marketplace.{Business}
  alias Atmanirbhar.Catalog.Product

  import Ecto.Query, warn: false
  import Ecto.Changeset, warn: false
  alias Atmanirbhar.Repo

  # defdelegate get_basket_items(basket_id, store_id), to: Basket, as: :basket_items_of_store
  # defdelegate get_basket_items(basket_id, store_id) , to: Basket, as: :basket_items_of_store
  def get_basket_items(basket_id, store_id) do
    basket = get_basket(basket_id)

    Ecto.assoc(basket, :basket_items)
    |> Repo.all
  end

  def add_to_basket(product_id, customer_basket_id, business_id) do
    basket =
      customer_basket_id
      |> get_basket()

    {int_product_id, _} = Integer.parse(product_id)
    # {int_business_id, _} = Integer.parse(business_id)

    query = from(item in BasketItem, update: [inc: [quantity: 1]])

    attrs = %{
      product_id: int_product_id,
      business_id: business_id,
      quantity: 1
    }
    build_basket_item = Ecto.build_assoc(basket, :basket_items, attrs)


    Repo.insert!(
      # %BasketItem{product_id: int_product_id, business_id: int_business_id, quantity: 1}
      build_basket_item,
      on_conflict: query,
      conflict_target: [:business_id, :product_id]
    )


    # build_basket_item
    # |> BasketItem.changeset(attrs)
    # |> Repo.insert!

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
