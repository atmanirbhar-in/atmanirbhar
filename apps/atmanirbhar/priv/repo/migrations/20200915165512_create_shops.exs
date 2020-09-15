defmodule Atmanirbhar.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add :name, :string
      add :name_hindi, :string
      add :description, :text

      timestamps()
    end

  end
end
