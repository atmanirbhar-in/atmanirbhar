defmodule Atmanirbhar.Geo.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :match_slugs, {:array, :string}
    field :nearby_slugs, {:array, :string}
    field :slug, :string
    field :title, :string
    # field :is_city, :boolean, default: false

    timestamps()
  end

  # TODO add city flag.
  # When seller tries to set his ad location,
  # it should NOT be a city, but region.
  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:slug, :is_city, :match_slugs, :nearby_slugs, :title])
    |> validate_required([:slug, :is_city, :match_slugs, :nearby_slugs, :title])
    |> unique_constraint(:slug)
  end
end
