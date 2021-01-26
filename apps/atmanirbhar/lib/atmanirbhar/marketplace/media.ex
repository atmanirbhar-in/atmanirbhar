defmodule Atmanirbhar.Marketplace.Media do
  use Ecto.Schema
  import Ecto.Changeset
  alias Atmanirbhar.Marketplace.Business

  schema "marketplace_media" do
    field :active, :boolean, default: false
    field :caption, :string
    field :type, :string
    field :url, :string
    # field :business_id, :id

    belongs_to :business, Business
    timestamps()
  end

  @doc false
  def changeset(media, attrs) do
    media
    |> cast(attrs, [:active, :url, :caption, :type])
    |> validate_required([:active, :url, :caption, :type])
  end
end
