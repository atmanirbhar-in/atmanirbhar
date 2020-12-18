defmodule Atmanirbhar.Marketplace.Stall do
  use Ecto.Schema
  import Ecto.Changeset

  schema "marketplace_stalls" do
    field :audience_average, :integer
    field :description, :string
    field :for_female, :boolean, default: false
    field :for_male, :boolean, default: false
    field :is_active, :boolean, default: false
    field :poster_image_url, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(stall, attrs) do
    stall
    |> cast(attrs, [:title, :description, :audience_average, :for_male, :for_female, :poster_image_url, :is_active])
    |> validate_required([:title, :description, :audience_average, :for_male, :for_female, :poster_image_url, :is_active])
  end
end
