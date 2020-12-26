defmodule Atmanirbhar.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :title, :string
      add :description, :text
      add :address, :string
      add :power_index, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :city_id, references(:locations, on_delete: :nothing)

      timestamps()
    end

    create index(:businesses, [:user_id])
    create index(:businesses, [:city_id])
  end
end
