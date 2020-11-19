defmodule Atmanirbhar.BulkUpload.BusinessImportJob do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :uploaded_by, :string
    field :city_name, :string
    # field :business_name, :string
    # field :product_kind_of, :string
    field :file, :any, virtual: true
  end

  @doc false
  # create notification message informing new kind_of.
  # add uploaded by from who is loggedIn
  # validations
  def changeset(business_import_job, attrs) do
    business_import_job
    # |> cast(attrs, [:business_name, :product_kind_of])
    |> cast(attrs, [:city_name, :file])
  end

  # moderator name
  defp attach_imported_by(changeset) do
    changeset
  end

end
