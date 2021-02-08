defmodule Atmanirbhar.Marketplace.StallAtlas do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :media_ids, {:array, :integer}, default: []
    field :product_ids, {:array, :integer}, default: []
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:media_ids, :product_ids])
  end

  # , {:array, :integer}, default: []
  # field :media_ids, {:array, :integer}, default: []

  # def changeset() do
  # end
end
