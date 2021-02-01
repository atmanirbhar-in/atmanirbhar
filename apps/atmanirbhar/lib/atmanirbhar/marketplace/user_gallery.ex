# defmodule Atmanirbhar.Marketplace.UserGallery do
#   use Ecto.Schema
#   import Ecto.Changeset
#   alias Atmanirbhar.Accounts.User

#   schema "marketplace_user_gallery" do
#     field :active, :boolean, default: false
#     # field :user_id, :id

#     timestamps()
#     belongs_to :user, User
#     # has_many :gallery_items, Atmanirbhar.Marketplace.GalleryItem
#   end

#   @doc false
#   def changeset(user_gallery, attrs) do
#     user_gallery
#     |> cast(attrs, [:active])
#     |> validate_required([:active])
#   end
# end
