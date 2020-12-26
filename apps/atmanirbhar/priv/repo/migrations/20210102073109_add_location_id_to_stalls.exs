defmodule Atmanirbhar.Repo.Migrations.AddLocationIdToStalls do
  use Ecto.Migration

  def change do
    alter table(:marketplace_stalls) do
      add :location_id, references(:locations, on_delete: :nothing)
    end

  end
end
