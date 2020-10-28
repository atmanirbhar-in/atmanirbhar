defmodule Atmanirbhar.Resources.RawMaterial do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raw_materials" do
    field :category_id, :string
    field :name, :string
    field :package_quantity, :string
    field :picture_url, :string
    field :retail_price, :integer
    field :wholesale_price, :integer
    field :seller_id, :string

    timestamps()
  end

  @doc false
  def changeset(raw_material, attrs) do
    raw_material
    |> cast(attrs, [:name, :package_quantity, :picture_url,
                   :retail_price, :wholesale_price,
                   :category_id, :seller_id])
                   |> validate_required([:name, :package_quantity, :picture_url,
                                        :retail_price, :wholesale_price,
                                        :category_id,
                                        :seller_id])
  end
end
