defmodule Atmanirbhar.Repo.Migrations.RenameStallElementsToGalleryItems do
  use Ecto.Migration

  def change do
    rename table(:marketplace_stall_elements), to: table(:gallery_items)
    rename table(:marketplace_stall_items), :stall_element_id, to: :gallery_item_id
  end
end
