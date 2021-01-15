defmodule Atmanirbhar.Repo.Migrations.CreateMarketplaceUserGallery do
  use Ecto.Migration

  def change do
    create table(:marketplace_user_gallery) do
      add :active, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:marketplace_user_gallery, [:user_id])
  end
end
