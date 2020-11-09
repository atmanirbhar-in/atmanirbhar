defmodule Atmanirbhar.Marketplace.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "marketplace_products" do
    field :delivery_details, :string
    field :description, :string
    field :price, :integer
    field :blueprint_id, :id
    field :business_owner, :id
    field :location_id, :id

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:price, :description, :delivery_details])
    |> validate_required([:price, :description, :delivery_details])
  end
end
