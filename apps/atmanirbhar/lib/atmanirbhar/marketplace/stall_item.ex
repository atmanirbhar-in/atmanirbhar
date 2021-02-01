# defmodule Atmanirbhar.Marketplace.StallItem do
#   use Ecto.Schema
#   import Ecto.Changeset
#   alias Atmanirbhar.Marketplace.{Stall, GalleryItem}

#   schema "marketplace_stall_items" do
#     belongs_to(:stall, Stall)
#     belongs_to(:gallery_item, GalleryItem)

#     timestamps()
#   end

#   @doc false
#   def changeset(stall_item, attrs) do
#     stall_item
#     |> cast(attrs, [])
#     |> validate_required([])
#   end
# end
