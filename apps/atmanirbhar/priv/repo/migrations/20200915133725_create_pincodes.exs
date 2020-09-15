defmodule Atmanirbhar.Repo.Migrations.CreatePincodes do
  use Ecto.Migration

  def change do
    create table(:pincodes) do
      add :name, :integer
      add :city, :string
      add :description, :string

      timestamps()
    end

  end
end
