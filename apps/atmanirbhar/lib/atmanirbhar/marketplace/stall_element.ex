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
    many_to_many(:stalls, Stall, join_through: StallItem, on_replace: :delete)
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
    # |> maybe_mark_for_deletion
  end

  def product_changeset(stall_element, attrs) do
    stall_element
    |> cast(attrs, [:title, :description, :images])
    |> validate_required([:title, :description])
  end

  def timeline_post_changeset(stall_element, attrs) do
    stall_element
    |> cast(attrs, [:title, :description, :images])
    |> validate_required([:title, :description])
  end

  # defp maybe_mark_for_deletion(changeset) do
  #   if get_change(changeset, :delete) do
  #     %{changeset | action: :delete}
  #   else
  #     changeset
  #   end
  # end

end
