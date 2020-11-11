defmodule Atmanirbhar.Marketplace.Business do
  use Ecto.Schema
  import Ecto.Changeset

  schema "businesses" do
    field :address, :string
    field :description, :string
    field :power_index, :integer
    field :title, :string
    # field :owner_id, :id
    field :city_id, :id
    field :areas_id, :id

    belongs_to :users, Atmanirbhar.Accounts.User, foreign_key: :owner_id
    timestamps()
  end

  def with_owner_changeset(business, attrs) do
    #
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:title, :owner_id, :description, :address, :power_index])
    |> validate_required([:title, :description, :address, :power_index])
  end
end
