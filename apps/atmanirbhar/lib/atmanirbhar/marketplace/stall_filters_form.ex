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

  # @doc false
  # def changeset(location_form, attrs) do
  #   location_form
  #   |> cast(attrs, [:pincode])
  #   |> validate_required([:pincode])
  #   |> validate_length(:pincode, is: 6)
  # end

end
