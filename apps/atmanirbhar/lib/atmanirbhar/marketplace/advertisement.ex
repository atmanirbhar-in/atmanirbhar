defmodule Atmanirbhar.Marketplace.Advertisement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "advertisements" do
    field :availability, :string
    field :description, :string
    field :is_approved, :boolean, default: false
    field :name, :string
    field :name_hindi, :string
    field :price, :integer

    timestamps()
  end

  @doc false
  def changeset(advertisement, attrs) do
    advertisement
    |> cast(attrs, [:name, :name_hindi, :description, :availability, :price, :is_approved])
    |> validate_required([:name, :name_hindi, :description, :availability, :price, :is_approved])
  end
end
