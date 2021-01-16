defmodule Atmanirbhar.Marketplace.GalleryUpload do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :title, :string
    field :description, :string
  end

  @doc false
  def changeset(gallery_upload, attrs) do
    gallery_upload
    |> cast(attrs, [:title])
  end

end
