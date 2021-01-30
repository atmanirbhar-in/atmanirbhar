defmodule Atmanirbhar.Repo.Migrations.StallEmbeddsAMapStallAtlas do
  use Ecto.Migration

  def change do
    alter table(:marketplace_stalls) do
      add :stall_atlas, :map, default: %{}
    end
  end
end
