defmodule Atmanirbhar.Repo.Migrations.UserHasOneBusinessOnly do
  use Ecto.Migration

  def change do
    # changed in migration
    # rename table(:businesses), :owner_id, to: :user_id
    # create index(:businesses, [:user_id])
    # # execute "ALTER INDEX businesses_owner_id RENAME TO businesses_user_id"

  end

end
