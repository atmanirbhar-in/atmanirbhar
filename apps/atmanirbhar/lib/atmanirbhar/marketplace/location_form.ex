defmodule Atmanirbhar.Marketplace.LocationForm do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :pincode, :string
  end

  @doc false
  def changeset(location_form, attrs) do
    location_form
    |> cast(attrs, [:pincode])
    |> validate_required([:pincode])
    |> validate_length(:pincode, is: 6)
  end
end
