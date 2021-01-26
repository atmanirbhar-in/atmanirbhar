defmodule Atmanirbhar.Marketplace.BusinessMediaItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "business_media_item" do
    field :business_id, :id
    field :media_id, :id

    timestamps()
  end

  @doc false
  def changeset(business_media, attrs) do
    business_media
    |> cast(attrs, [])
    |> validate_required([])
  end
end
