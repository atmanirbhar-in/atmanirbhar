defmodule Atmanirbhar.Checkout.BasketItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "basket_items" do
    field :quantity, :integer
    field :variation, :string
    field :basket_id, :id
    field :business_id, :id
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(basket_item, attrs) do
    basket_item
    |> cast(attrs, [:variation, :quantity])
    |> validate_required([:variation, :quantity])
  end
end
