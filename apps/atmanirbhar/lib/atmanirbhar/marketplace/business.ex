defmodule Atmanirbhar.Marketplace.Business do
  use Ecto.Schema
  import Ecto.Changeset

  schema "businesses" do
    field :address, :string
    field :description, :string
    field :power_index, :integer
    field :title, :string
    field :owner_id, :id
    field :city_id, :id
    field :areas_id, :id

    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:title, :description, :address, :power_index])
    |> validate_required([:title, :description, :address, :power_index])
  end
end
