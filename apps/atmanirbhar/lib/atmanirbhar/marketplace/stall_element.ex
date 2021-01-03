defmodule Atmanirbhar.Marketplace.StallElement do
  use Ecto.Schema
  import Ecto.Changeset
  alias Atmanirbhar.Marketplace.{Stall, StallItem}

  schema "marketplace_stall_elements" do
    field :description, :string
    field :images, {:array, :string}
    field :title, :string
    field :type, :integer

    timestamps()
    many_to_many(:stalls, Stall, join_through: StallItem)
  end

  @doc """
  1 - Product
  2 - Timeline-item
  3 - Deal
  4 - promoted Ad
  1 - Product
  2 - Timeline-item
  3 - Deal
  4 - promoted Ad
  """
  def changeset(stall_element, attrs) do
    stall_element
    |> cast(attrs, [:type, :images, :description, :title])
    |> validate_required([:type, :images, :description, :title])
  end

  # set type as 1
  def product_changeset(stall_element, attrs) do
    stall_element
    |> cast(attrs, [:title, :description, :images])
    |> validate_required([:title, :description, :images])
  end
end
