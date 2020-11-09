defmodule Atmanirbhar.Repo.Migrations.CreateCatalogBlueprints do
  use Ecto.Migration

  def change do
    create table(:catalog_blueprints) do
      add :title, :string
      add :blueprint_code, :string
      add :description_hint, :text
      add :search_terms, :string
      add :taxonomy, :string

      timestamps()
    end

    create unique_index(:catalog_blueprints, [:blueprint_code])
  end
end
