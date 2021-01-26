defmodule Atmanirbhar.Repo.Migrations.CreateBusinessMedia do
  use Ecto.Migration

  def change do
    create table(:business_media) do
      add :business_id, references(:businesses, on_delete: :nothing)
      add :media_id, references(:marketplace_media, on_delete: :nothing)

      timestamps()
    end

    create index(:business_media, [:business_id])
    create index(:business_media, [:media_id])
  end
end
