defmodule Atmanirbhar.Checkout do
  alias Atmanirbhar.Checkout.{Order, Basket}

  import Ecto.Query, warn: false
  import Ecto.Changeset, warn: false
  alias Atmanirbhar.Repo

  # def add_to_cart(product, customer, business) do
  # end

  defdelegate add_to_basket(product, customer, business), to: Order, as: :add

  def remove_from_cart(product, customer, business) do
  end

  def get_basket(basket_id) do
    # {:ok, basket} =
    #   basket
      Repo.get!(Basket, basket_id)
  end

  def create_basket() do
    %Basket{}
    |> Basket.changeset(%{is_guest: true})
    |> Repo.insert()
  end



end
