defmodule Atmanirbhar.Marketplace.BulkUpload do
  use Ecto.Schema
  import Ecto.Changeset

  schema "marketplace_bulk_uploads" do
    field :city_name, :string
    field :content_description, :string
    field :file_url, :string
    field :location_name, :string
    field :processesed_flag, :boolean, default: false
    field :uploaded_by_user_id, :id

    timestamps()
  end

  @doc false
  def changeset(bulk_upload, attrs) do
    bulk_upload
    |> cast(attrs, [:file_url, :city_name, :location_name, :content_description, :processesed_flag])
    |> validate_required([:file_url, :city_name, :location_name, :content_description, :processesed_flag])
  end
end
