defmodule Atmanirbhar.Marketplace.Stall do
  use Ecto.Schema
  import Ecto.Changeset
  alias Atmanirbhar.Marketplace.{Business, GalleryItem, StallAtlas}
  alias Atmanirbhar.Geo.Location

  schema "marketplace_stalls" do
    field :audience_average, :integer
    field :description, :string
    field :for_female, :boolean, default: false
    field :for_male, :boolean, default: false
    field :is_active, :boolean, default: false
    field :poster_image_url, :string
    field :title, :string
    # field :stall_product_ids, {:array, :integer}, default: []
    # field :stall_media_ids, {:array, :integer}, default: []

    many_to_many(:gallery_items, GalleryItem, join_through: StallItem, on_replace: :delete)

    timestamps()

    belongs_to :business, Business
    belongs_to :location, Location

    embeds_one :stall_atlas, StallAtlas
  end

  def changeset(stall, attrs) do
    stall
    |> cast(attrs, [
          :title, :description, :location_id,
          :audience_average, :for_male, :for_female,
          :poster_image_url, :is_active,
        ])
        |> validate_required([:title, :description, :audience_average, :for_male, :for_female, :is_active])
        |> cast_embed(:stall_atlas)
        |> validate_inclusion(:audience_average, 5..100)
        # |> put_embed(:stall_atlas)
    # |> cast_assoc(:gallery_items, required: true, on_replace: :delete)
    # |> cast_embed(:stall_media_ids, required: true)
  end

  def create_changeset(stall, attrs) do
    stall
    |> cast(attrs, [:title, :description, :business_id,
                   :location_id, :audience_average, :for_male, :for_female,
                   :poster_image_url, :is_active,
                   :stall_media_ids, :stall_product_ids,
                   ])
    |> validate_required([:title, :description, :audience_average, :for_male, :for_female, :is_active])
    # |> cast_assoc(:gallery_items, required: true, on_replace: :delete)
  end


end
