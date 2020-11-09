defmodule Atmanirbhar.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :slug, :string
      add :match_slugs, {:array, :string}
      add :nearby_slugs, {:array, :string}
      add :title, :string

      timestamps()
    end

    create unique_index(:locations, [:slug])
  end
end
