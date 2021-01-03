defmodule Atmanirbhar.Marketplace.Product do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
