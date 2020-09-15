defmodule Atmanirbhar.Repo.Migrations.CreateAdvertisements do
  use Ecto.Migration

  def change do
    create table(:advertisements) do
      add :name, :string
      add :name_hindi, :string
      add :description, :text
      add :availability, :text
      add :price, :integer
      add :is_approved, :boolean, default: false, null: false

      timestamps()
    end

  end
end
