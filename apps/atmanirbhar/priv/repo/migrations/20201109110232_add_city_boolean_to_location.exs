defmodule Atmanirbhar.Repo.Migrations.AddCityBooleanToLocation do
  use Ecto.Migration

  def change do
    alter table(:locations) do
      add :is_city, :boolean, default: false, null: false
    end

  end
end
