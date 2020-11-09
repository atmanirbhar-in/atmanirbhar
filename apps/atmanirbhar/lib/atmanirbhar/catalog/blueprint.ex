defmodule Atmanirbhar.Catalog.Blueprint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "catalog_blueprints" do
    field :blueprint_code, :string
    field :description_hint, :string
    field :search_terms, :string
    field :taxonomy, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(blueprint, attrs) do
    blueprint
    |> cast(attrs, [:title, :blueprint_code, :description_hint, :search_terms, :taxonomy])
    |> validate_required([:title, :blueprint_code, :description_hint, :search_terms, :taxonomy])
    |> unique_constraint(:blueprint_code)
  end
end
