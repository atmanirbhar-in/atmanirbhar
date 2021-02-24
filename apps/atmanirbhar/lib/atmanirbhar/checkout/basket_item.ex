defmodule Atmanirbhar.Checkout.BasketItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias Atmanirbhar.Checkout.Basket
  alias Atmanirbhar.Catalog.Product

  schema "basket_items" do
    field :quantity, :integer
    field :variation, :string
    # field :basket_id, :id
    field :business_id, :id
    # field :product_id, :id

    timestamps()
    belongs_to :basket, Basket
    belongs_to :product, Product
  end

  @doc false
  def changeset(basket_item, attrs) do
    basket_item
    |> cast(attrs, [:variation, :quantity])
    |> validate_required([:quantity])
  end
end
