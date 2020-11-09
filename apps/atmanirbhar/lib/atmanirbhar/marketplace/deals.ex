defmodule Atmanirbhar.Marketplace.Deals do
  use Ecto.Schema
  import Ecto.Changeset

  schema "marketplace_products_deals" do
    field :date, :date
    field :price, :integer
    field :status, :integer
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(deals, attrs) do
    deals
    |> cast(attrs, [:price, :date, :status])
    |> validate_required([:price, :date, :status])
  end
end
