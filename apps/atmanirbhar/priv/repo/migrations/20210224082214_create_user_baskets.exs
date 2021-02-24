defmodule Atmanirbhar.Repo.Migrations.CreateUserBaskets do
  use Ecto.Migration

  def change do
    create table(:user_baskets) do
      add :is_guest, :boolean, default: false, null: false
      add :customer_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:user_baskets, [:customer_id])
  end
end
