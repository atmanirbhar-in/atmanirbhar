defmodule Atmanirbhar.Checkout do
  alias Atmanirbhar.Checkout.{Order, Basket, BasketItem}
  alias Atmanirbhar.Marketplace.{Business}
  alias Atmanirbhar.Catalog.Product

  import Ecto.Query, warn: false
  import Ecto.Changeset, warn: false
  alias Atmanirbhar.Repo

  def get_basket_items(basket_id, store_id) do
    basket = get_basket(basket_id)

    Ecto.assoc(basket, :basket_items)
    |> Repo.all
  end

  def get_store_basket_items_map(basket_id, store_id) do
      query = from bi in Atmanirbhar.Checkout.BasketItem,
      where: bi.basket_id ==^basket_id,
      where: bi.business_id == ^store_id,
      select: {bi.product_id, bi.quantity}

      query
      |> Repo.all
      |> Enum.into(%{})
  end

  def add_to_basket(product_id, customer_basket_id, business_id) do
    basket =
      customer_basket_id
      |> get_basket()

    {int_product_id, _} = Integer.parse(product_id)
    query = from(item in BasketItem, update: [inc: [quantity: 1]])

    attrs = %{
      product_id: int_product_id,
      business_id: business_id,
      quantity: 1
    }
    build_basket_item = Ecto.build_assoc(basket, :basket_items, attrs)

    Repo.insert!(
      build_basket_item,
      returning: true,
      on_conflict: query,
      conflict_target: [:product_id, :business_id]
    )
  end

  def remove_from_basket(product_id, customer_basket_id, store_id) do
    quantity = -1

    query = from item in BasketItem,
      where: item.basket_id == ^customer_basket_id,
      where: item.product_id == ^product_id,
      where: item.business_id == ^store_id,
      where: item.quantity > 0,
      update: [inc: [quantity: -1]]

    Repo.update_all(query, [])
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
