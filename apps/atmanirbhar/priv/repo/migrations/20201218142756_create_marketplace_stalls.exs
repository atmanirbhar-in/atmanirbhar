defmodule Atmanirbhar.Repo.Migrations.CreateMarketplaceStalls do
  use Ecto.Migration

  def change do
    create table(:marketplace_stalls) do
      add :title, :string
      add :description, :text
      add :audience_average, :integer
      add :for_male, :boolean, default: false, null: false
      add :for_female, :boolean, default: false, null: false
      add :poster_image_url, :string
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
