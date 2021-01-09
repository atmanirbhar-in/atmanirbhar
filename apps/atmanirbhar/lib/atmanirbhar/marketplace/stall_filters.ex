defmodule Atmanirbhar.Marketplace.StallFilters do
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

  def stall_filters_from_params(params) do
    # IO.puts "line 137"

    # default_options = %{
    #   show_male: true,
    #   show_female: true,
    #   audience_min: 20,
    #   audience_max: 60
    # }

    # StallFilters.changeset(stall_filters, default_options)
  end


  def query_for(%__MODULE__{} = stall_filters) do
    # IO.puts "params - sf"
    # IO.puts inspect(params)

    for_male = Map.get(stall_filters, :for_male, true)
    for_female = Map.get(stall_filters, :for_female, true)
    audience_min = Map.get(stall_filters, :audience_min, 20)
    audience_max = Map.get(stall_filters, :audience_max, 60)
    pincode = Map.get(stall_filters, :pincode, 12345)

    # {_, for_male} = changeset.fetch_fields(changeset, :for_male)
    # {_, for_female} = changeset.fetch_fields(changeset, :for_female)
    # {_, audience_min} = changeset.fetch_fields(changeset, :audience_min)
    # {_, audience_max} = changeset.fetch_fields(changeset, :audience_max)
    # {_, pincode} = changeset.fetch_fields(changeset, :pincode)

    build_query_for(%{
      show_male: for_male,
      show_female: for_female,
      audience_min: audience_min,
      audience_max: audience_max,
      pincode: pincode
                    })
  end

  defp build_query_for(%{show_male: true, show_female: false, audience_min: audience_min, audience_max: audience_max} = form_params) do
    from s in Stall,
      where: s.for_male == true and s.audience_average >= ^audience_min and s.audience_average <= ^audience_max,
      order_by: [desc: s.inserted_at]
  end
  defp build_query_for(%{show_male: false, show_female: true, audience_min: audience_min, audience_max: audience_max} = form_params) do
    # IO.puts inspect(form_params)
    from s in Stall,
      where: s.for_female == true and s.audience_average >= ^audience_min and s.audience_average <= ^audience_max,
      order_by: [desc: s.inserted_at]
  end
  defp build_query_for(%{show_male: _show_male, show_female: _show_female, audience_min: audience_min, audience_max: audience_max} = form_params) do
    from s in Stall,
      where: s.audience_average >= ^audience_min and s.audience_average <= ^audience_max,
      order_by: [desc: s.inserted_at]
  end

end
