defmodule Atmanirbhar.Repo.Migrations.AddGalleryIdOnGalleryItem do
  use Ecto.Migration

  def change do
    alter table(:gallery_items) do
      add :gallery_id, references(:marketplace_user_gallery, on_delete: :delete_all)
    end

  end
end
