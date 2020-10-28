defmodule Atmanirbhar.Repo.Migrations.CreateRawMaterials do
  use Ecto.Migration

  def change do
    create table(:raw_materials) do
      add :name, :string
      add :package_quantity, :string
      add :picture_url, :string
      add :price, :string
      add :category_id, :string
      add :seller_id, :string

      timestamps()
    end

  end
end
