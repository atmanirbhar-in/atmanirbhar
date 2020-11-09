defmodule Atmanirbhar.Repo.Migrations.CreateMarketplaceProductsDeals do
  use Ecto.Migration

  def change do
    create table(:marketplace_products_deals) do
      add :price, :integer
      add :date, :date
      add :status, :integer
      add :product_id, references(:marketplace_products, on_delete: :nothing)

      timestamps()
    end

    create index(:marketplace_products_deals, [:product_id])
  end
end
