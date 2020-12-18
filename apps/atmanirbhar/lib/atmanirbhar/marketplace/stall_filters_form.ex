defmodule Atmanirbhar.Marketplace.StallFiltersForm do
  use Ecto.Schema
  import Ecto.Query, warn: false
  alias Atmanirbhar.Marketplace.{Stall}
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

  def query_for(%{show_male: true, show_female: false, audience_min: audience_min, audience_max: audience_max} = form_params) do
    from s in Stall,
      where: s.for_male == true and s.audience_average >= ^audience_min and s.audience_average <= ^audience_max,
      order_by: [desc: s.inserted_at]
  end
  def query_for(%{show_male: false, show_female: true, audience_min: audience_min, audience_max: audience_max} = form_params) do
    IO.puts inspect(form_params)
    from s in Stall,
      where: s.for_female == true and s.audience_average >= ^audience_min and s.audience_average <= ^audience_max,
      order_by: [desc: s.inserted_at]
  end
  def query_for(%{show_male: _show_male, show_female: _show_female, audience_min: audience_min, audience_max: audience_max} = form_params) do
    from s in Stall,
      where: s.audience_average >= ^audience_min and s.audience_average <= ^audience_max,
      order_by: [desc: s.inserted_at]
  end

end
