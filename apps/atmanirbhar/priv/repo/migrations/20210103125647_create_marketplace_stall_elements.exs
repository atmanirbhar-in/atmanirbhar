defmodule Atmanirbhar.Repo.Migrations.CreateMarketplaceStallElements do
  use Ecto.Migration

  def change do
    create table(:marketplace_stall_elements) do
      add :type, :integer
      add :images, {:array, :string}
      add :description, :text
      add :title, :string

      timestamps()
    end

  end
end
