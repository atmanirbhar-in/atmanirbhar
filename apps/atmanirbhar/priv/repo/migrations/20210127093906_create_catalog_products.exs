defmodule Atmanirbhar.Repo.Migrations.CreateCatalogProducts do
  use Ecto.Migration

  def change do
    create table(:catalog_products) do
      add :title, :string
      add :description, :text
      add :images, {:array, :string}
      add :delivery_details, :text
      add :unit_price_inr, :string
      add :deliverables, :text
      add :business_id, references(:businesses, on_delete: :nothing)

      timestamps()
    end

    create index(:catalog_products, [:business_id])
  end
end
