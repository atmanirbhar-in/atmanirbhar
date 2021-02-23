defmodule Atmanirbhar.Repo.Migrations.CreateOrderDetails do
  use Ecto.Migration

  def change do
    create table(:order_details) do
      add :variation, :string
      add :order_id, references(:orders, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :nothing)
      add :product_id, references(:catalog_products, on_delete: :nothing)

      timestamps()
    end

    create index(:order_details, [:order_id])
    create index(:order_details, [:business_id])
    create index(:order_details, [:product_id])
  end
end
