defmodule Atmanirbhar.Marketplace.Business do
  use Ecto.Schema
  import Ecto.Changeset

  # business picture
  schema "businesses" do
    field :address, :string
    field :description, :string
    field :power_index, :integer
    field :title, :string
    # field :owner_id, :id
    field :city_id, :id
    field :areas_id, :id

    belongs_to :user, Atmanirbhar.Accounts.User, foreign_key: :owner_id
    has_many :stalls, Atmanirbhar.Marketplace.Stall
    has_many :medias, Atmanirbhar.Marketplace.Media
    has_many :products, Atmanirbhar.Catalog.Product
    timestamps()
  end

  def with_owner_changeset(business, attrs) do
    #
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:title, :description, :address])
    |> validate_required([:title])
  end
end
