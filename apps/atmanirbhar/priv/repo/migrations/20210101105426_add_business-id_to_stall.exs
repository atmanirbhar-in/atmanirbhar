defmodule :"Elixir.Atmanirbhar.Repo.Migrations.AddBusiness-idToStall" do
  use Ecto.Migration

  def change do
    alter table(:marketplace_stalls) do
      add :business_id, references(:businesses, on_delete: :delete_all), null: false, default: 1
    end

  end
end
