defmodule Atmanirbhar.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :order_date, :date
      add :preferred_delivery_datetime, :utc_datetime
      add :error_message, :string
      add :error_location, :string
      add :fullfilled, :boolean, default: false, null: false
      add :deleted, :boolean, default: false, null: false
      add :customer_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :nothing)

      timestamps()
    end

    create index(:orders, [:customer_id])
    create index(:orders, [:business_id])
  end
end
