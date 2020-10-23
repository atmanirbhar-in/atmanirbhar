defmodule Atmanirbhar.Repo.Migrations.CreateDeals do
  use Ecto.Migration

  def change do
    create table(:deals) do
      add :name, :string
      add :name_hindi, :string
      add :description, :text
      add :availability, :text
      add :price, :integer
      add :is_approved, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:deals, [:user_id])
  end
end
