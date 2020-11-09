defmodule Atmanirbhar.Geo.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :match_slugs, {:array, :string}
    field :nearby_slugs, {:array, :string}
    field :slug, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:slug, :match_slugs, :nearby_slugs, :title])
    |> validate_required([:slug, :match_slugs, :nearby_slugs, :title])
    |> unique_constraint(:slug)
  end
end
