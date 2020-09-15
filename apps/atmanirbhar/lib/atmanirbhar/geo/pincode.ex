defmodule Atmanirbhar.Geo.Pincode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pincodes" do
    field :city, :string
    field :description, :string
    field :name, :integer

    timestamps()
  end

  @doc false
  def changeset(pincode, attrs) do
    pincode
    |> cast(attrs, [:name, :city, :description])
    |> validate_required([:name, :city, :description])
  end
end
