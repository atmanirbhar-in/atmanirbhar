defmodule Atmanirbhar.Repo.Migrations.CreateMarketplaceMedia do
  use Ecto.Migration

  def change do
    create table(:marketplace_media) do
      add :active, :boolean, default: false, null: false
      add :url, :string
      add :caption, :text
      add :type, :string
      add :business_id, references(:businesses, on_delete: :nothing)

      timestamps()
    end

    create index(:marketplace_media, [:business_id])
  end
end
