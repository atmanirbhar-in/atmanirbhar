defmodule Atmanirbhar.Marketplace.StallFiltersForm do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :pincode, :string
    field :show_male, :boolean
    field :show_female, :boolean
    field :audience_min, :integer
    field :audience_max, :integer
  end

  @doc false
  def changeset(stall_filters_form, attrs) do
    stall_filters_form
    |> cast(attrs, [:show_male, :show_female, :audience_max, :audience_min])
    # |> validate_required([:pincode])
    # |> validate_length(:pincode, is: 6)
  end

end
