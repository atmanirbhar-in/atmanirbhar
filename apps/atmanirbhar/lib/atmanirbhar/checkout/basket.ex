defmodule Atmanirbhar.Checkout.Basket do
  use Ecto.Schema
  import Ecto.Changeset
  alias Atmanirbhar.Checkout.BasketItem
  alias Atmanirbhar.Checkout

  schema "user_baskets" do
    field :is_guest, :boolean, default: false
    field :customer_id, :id

    timestamps()
    has_many :basket_items, BasketItem
  end

  @doc false
  def changeset(basket, attrs) do
    basket
    |> cast(attrs, [:is_guest])
    |> validate_required([:is_guest])
  end


end
