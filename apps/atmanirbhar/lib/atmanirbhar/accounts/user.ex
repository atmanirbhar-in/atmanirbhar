defmodule Atmanirbhar.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema
  alias Atmanirbhar.Marketplace.{GalleryItem, UserGallery}
  alias Atmanirbhar.Repo

  @derive {Inspect, except: [:password]}
  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :confirmed_at, :naive_datetime
    field :avatar, Atmanirbhar.AvatarUploader.Type
    # field :business, :string, virtual: true
    # field :city, :string, virtual: true

    has_one :business, Atmanirbhar.Marketplace.Business

    timestamps()
  end

  @doc """
  A user changeset for registration.

  It is important to validate the length of both e-mail and password.
  Otherwise databases may truncate the e-mail without warnings, which
  could lead to unpredictable or insecure behaviour. Long passwords may
  also be very expensive to hash for certain algorithms.
  """

  # def registration_form_changeset(user, attrs) do
  #   user
  #   |> cast(attrs, [:email, :password, :business, :city])
  #   |> validate_email()
  #   |> validate_password()
  #   |> validate_business()
  #   |> validate_city()
  # end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> cast_assoc(:business, required: true)
    |> validate_email()
    |> validate_password()

    # |> validate_business()
    # |> validate_city()
    # |> Repo.preload(:businesses)
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

  @doc """
  A user changeset for changing the e-mail.

  It requires the e-mail to change otherwise an error is added.
  """
  def email_changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_email()
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

  @doc """
  A user changeset for changing the password.
  """
  def password_changeset(user, attrs) do
    user
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_password()
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(user) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    change(user, confirmed_at: now)
  end

  @doc """
  Verifies the password.

  If there is no user or the user doesn't have a password, we call
  `Bcrypt.no_user_verify/0` to avoid timing attacks.
  """
  def valid_password?(%Atmanirbhar.Accounts.User{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

  @doc """
  Validates the current password otherwise adds an error to the changeset.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end

  def avatar_changeset(user, attrs) do
    user
    |> cast(attrs, [])
    |> cast_attachments(attrs, [:avatar])
  end
end
