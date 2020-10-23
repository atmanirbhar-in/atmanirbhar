defmodule Atmanirbhar.Marketplace.Deal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "deals" do
    field :availability, :string
    field :description, :string
    field :is_approved, :boolean, default: false
    field :name, :string
    field :name_hindi, :string
    field :price, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(deal, attrs) do
    deal
    |> cast(attrs, [:name, :name_hindi, :description, :availability, :price, :is_approved])
    |> validate_required([:name, :name_hindi, :description, :availability, :price, :is_approved])
  end
end
