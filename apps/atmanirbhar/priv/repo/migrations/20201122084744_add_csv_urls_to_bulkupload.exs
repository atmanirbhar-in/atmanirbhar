defmodule Atmanirbhar.Repo.Migrations.AddCsvUrlsToBulkupload do
  use Ecto.Migration

  def change do
    alter table(:marketplace_bulk_uploads) do
      remove :file_url
      add :csv_urls, {:array, :string}, null: false, default: []
    end
  end
end
