defmodule Atmanirbhar.Repo.Migrations.CreateBasketItems do
  use Ecto.Migration

  def change do
    create table(:basket_items) do
      add :variation, :string
      add :quantity, :integer
      add :basket_id, references(:user_baskets, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :nothing)
      add :product_id, references(:catalog_products, on_delete: :nothing)

      timestamps()
    end

    create index(:basket_items, [:basket_id])
    create index(:basket_items, [:business_id])
    create index(:basket_items, [:product_id])
  end
end
