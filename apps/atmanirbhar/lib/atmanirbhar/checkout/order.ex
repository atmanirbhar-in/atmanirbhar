defmodule Atmanirbhar.Checkout.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :error_location, :string
    field :error_message, :string

    field :fullfilled, :boolean, default: false
    field :deleted, :boolean, default: false

    field :order_date, :date
    field :preferred_delivery_datetime, :utc_datetime

    field :customer_id, :id
    field :business_id, :id

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:order_date, :preferred_delivery_datetime, :error_message, :error_location, :fullfilled, :deleted])
    |> validate_required([:order_date, :preferred_delivery_datetime, :error_message, :error_location, :fullfilled, :deleted])
  end


  def add(product, customer, business) do
    IO.puts "product #{ product }"
  end

end
