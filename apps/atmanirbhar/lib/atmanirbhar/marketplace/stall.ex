defmodule Atmanirbhar.Marketplace.Stall do
  use Ecto.Schema
  import Ecto.Changeset
  alias Atmanirbhar.Marketplace.{Business, StallElement, StallItem}
  alias Atmanirbhar.Geo.Location

  schema "marketplace_stalls" do
    field :audience_average, :integer
    field :description, :string
    field :for_female, :boolean, default: false
    field :for_male, :boolean, default: false
    field :is_active, :boolean, default: false
    field :poster_image_url, :string
    field :title, :string
    field :stall_pods, :string, virtual: true
    # field :business_id, :id
    # field :location_id, :id

    many_to_many(:stall_elements, StallElement, join_through: StallItem, on_replace: :delete)

    timestamps()

    belongs_to :business, Business
    belongs_to :location, Location
  end

  # @doc false
  # def changeset(stall, attrs) do
  #   stall
  #   |> cast(attrs, [:title, :description, :business_id, :location_id, :audience_average, :for_male, :for_female, :poster_image_url, :is_active])
  #   |> validate_required([:title, :description, :audience_average, :for_male, :for_female, :is_active])
  #   |> cast_assoc(:stall_elements, required: true, on_replace: :nilify)
  # end

  # allow delete, ref many_to_many
  def changeset(stall, %{"delete" => "true"}) do
    %{Ecto.Changeset.change(stall) | action: :delete}
  end

  def changeset(stall, attrs) do
    stall
    |> cast(attrs, [:title, :description, :business_id, :location_id, :audience_average, :for_male, :for_female, :poster_image_url, :is_active])
    |> validate_required([:title, :description, :audience_average, :for_male, :for_female, :is_active])
    |> cast_assoc(:stall_elements, required: true, on_replace: :delete)
  end
end
