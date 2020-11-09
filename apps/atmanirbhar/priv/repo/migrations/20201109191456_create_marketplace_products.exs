defmodule Atmanirbhar.Repo.Migrations.CreateMarketplaceProducts do
  use Ecto.Migration

  def change do
    create table(:marketplace_products) do
      add :price, :integer
      add :description, :text
      add :delivery_details, :text
      add :blueprint_id, references(:catalog_blueprints, on_delete: :nothing)
      add :business_owner, references(:businesses, on_delete: :nothing)
      add :location_id, references(:locations, on_delete: :nothing)

      timestamps()
    end

    create index(:marketplace_products, [:blueprint_id])
    create index(:marketplace_products, [:business_owner])
    create index(:marketplace_products, [:location_id])
  end
end
