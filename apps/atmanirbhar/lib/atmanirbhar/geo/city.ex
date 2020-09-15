defmodule Atmanirbhar.Geo.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field :description, :string
    field :name, :string
    field :name_hinndi, :string

    timestamps()
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name, :name_hinndi, :description])
    |> validate_required([:name, :name_hinndi, :description])
  end
end
