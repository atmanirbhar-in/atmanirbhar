defmodule Atmanirbhar.Checkout.Basket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_baskets" do
    field :is_guest, :boolean, default: false
    field :customer_id, :id

    timestamps()
  end

  @doc false
  def changeset(basket, attrs) do
    basket
    |> cast(attrs, [:is_guest])
    |> validate_required([:is_guest])
  end

  # def create_for_guest do
  #   changeset(%__MODULE__{}, %{is_guest: true})
  # end

end
