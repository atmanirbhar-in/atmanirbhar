defmodule Atmanirbhar.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "catalog_products" do
    field :deliverables, :string
    field :delivery_details, :string
    field :description, :string
    field :images, {:array, :string}, nil: false, default: []
    field :title, :string
    field :unit_price_inr, :string
    # field :business_id, :id

    belongs_to :business, Atmanirbhar.Marketplace.Business
    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :title,
      :description,
      :images,
      :delivery_details,
      :unit_price_inr,
      :deliverables
    ])
    |> validate_required([:title, :description])
  end
end
