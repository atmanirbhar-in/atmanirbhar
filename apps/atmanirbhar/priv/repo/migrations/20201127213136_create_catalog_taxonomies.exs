defmodule Atmanirbhar.Repo.Migrations.CreateCatalogTaxonomies do
  use Ecto.Migration

  def change do
    create table(:catalog_taxonomies) do
      add :name, :string
      add :full_name, :string
      add :uniq, :integer
      add :parent_uniq, :integer
      add :is_visible, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(:catalog_taxonomies, [:name])
    create unique_index(:catalog_taxonomies, [:uniq])
  end
end
