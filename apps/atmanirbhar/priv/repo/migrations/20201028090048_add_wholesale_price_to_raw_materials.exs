defmodule Atmanirbhar.Repo.Migrations.AddWholesalePriceToRawMaterials do
  use Ecto.Migration

  def change do
    alter table(:raw_materials) do
      add :wholesale_price, :integer
      remove :price
      add :retail_price, :integer
    end
  end
end
