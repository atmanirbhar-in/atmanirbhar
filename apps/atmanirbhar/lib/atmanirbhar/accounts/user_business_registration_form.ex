defmodule Atmanirbhar.Accounts.UserBusinessRegistrationForm do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema
  alias Atmanirbhar.Marketplace.{GalleryItem, UserGallery}
  alias Atmanirbhar.Accounts.User

  embedded_schema do
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :confirmed_at, :naive_datetime
    field :avatar, Atmanirbhar.AvatarUploader.Type
    field :business, :string, virtual: true
    field :city, :string, virtual: true

    timestamps()
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :business, :city])
    |> validate_email()
    |> validate_password()
    |> validate_business()
    |> validate_city()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, Atmanirbhar.Repo)
    |> unique_constraint(:email)
  end

  defp validate_city(changeset) do
    changeset
    |> validate_required([:city])
  end
  defp validate_business(changeset) do
    changeset
    |> validate_required([:business])
    |> validate_length(:business, min: 12, max: 80)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 80)
    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> prepare_changes(&hash_password/1)
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)

    changeset
    |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
    |> delete_change(:password)
  end
end
