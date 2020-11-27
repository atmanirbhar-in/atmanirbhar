defmodule Atmanirbhar.Catalog.Taxonomy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "catalog_taxonomies" do
    field :full_name, :string
    field :is_visible, :boolean, default: false
    field :name, :string
    field :parent_uniq, :integer
    field :uniq, :integer

    timestamps()
  end

  @doc false
  def changeset(taxonomy, attrs) do
    taxonomy
    |> cast(attrs, [:name, :full_name, :uniq, :parent_uniq, :is_visible])
    |> validate_required([:name, :full_name, :uniq, :is_visible])
    |> unique_constraint(:name)
    |> unique_constraint(:uniq)
  end
end
