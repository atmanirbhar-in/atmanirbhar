defmodule Atmanirbhar.Marketplace.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :description, :string
    field :name, :string
    field :name_hindi, :string

    timestamps()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:name, :name_hindi, :description])
    |> validate_required([:name, :name_hindi, :description])
  end
end
