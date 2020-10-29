defmodule Atmanirbhar.Repo.Migrations.AddPincodeToDeals do
  use Ecto.Migration

  def change do
    alter table(:deals) do
      add :pincode, :integer
      add :city_id, references("cities")
    end
  end
 end
