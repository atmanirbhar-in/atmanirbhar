defmodule Atmanirbhar.Repo.Migrations.CreateMarketplaceStallItems do
  use Ecto.Migration

  def change do
    create table(:marketplace_stall_items) do
      add :stall_id, references(:marketplace_stalls, on_delete: :nothing)
      add :stall_element_id, references(:marketplace_stall_elements, on_delete: :nothing)

      timestamps()
    end

    create index(:marketplace_stall_items, [:stall_id])
    create index(:marketplace_stall_items, [:stall_element_id])
  end
end
