defmodule AtmanirbharWeb.UserRegistrationController do
  use AtmanirbharWeb, :controller

  alias Atmanirbhar.Accounts
  alias Atmanirbhar.Accounts.User
  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.Business
  alias AtmanirbharWeb.UserAuth

  def new(conn, _params) do
    # changeset = Accounts.change_user_registration(%User{businesses: [%Business{}]})
    user = Accounts.change_user_registration(%User{})
    business = Marketplace.change_business(%Business{})
    user_with_business = Ecto.Changeset.put_assoc(user, :businesses, [business])

    render(conn, "new.html", changeset: user_with_business)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
    # case Account.register_user_and_business(user_params, business_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :confirm, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.login_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
