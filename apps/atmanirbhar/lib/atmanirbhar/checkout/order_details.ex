defmodule Atmanirbhar.Checkout.OrderDetails do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_details" do
    field :variation, :string
    field :order_id, :id
    field :business_id, :id
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(order_details, attrs) do
    order_details
    |> cast(attrs, [:variation])
    |> validate_required([:variation])
  end
end
