defmodule Atmanirbhar.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string
      add :name_hinndi, :string
      add :description, :text

      timestamps()
    end

  end
end
