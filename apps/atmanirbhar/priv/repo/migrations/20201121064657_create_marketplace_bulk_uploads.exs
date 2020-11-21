defmodule Atmanirbhar.Repo.Migrations.CreateMarketplaceBulkUploads do
  use Ecto.Migration

  def change do
    create table(:marketplace_bulk_uploads) do
      add :file_url, :string
      add :city_name, :string
      add :location_name, :string
      add :content_description, :text
      add :processesed_flag, :boolean, default: false, null: false
      add :uploaded_by_user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:marketplace_bulk_uploads, [:uploaded_by_user_id])
  end
end
