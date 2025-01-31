defmodule Atmanirbhar.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Atmanirbhar.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"
  def valid_business_name, do: "business#{System.unique_integer()}"
  def valid_city_name, do: "city#{System.unique_integer()}"


  def user_with_business_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
          email: unique_user_email(),
          password: valid_user_password(),
          business: valid_business_name(),
                   })

      # Atmanirbhar.Accounts.register_user()
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        password: valid_user_password(),
        business: valid_business_name(),
        city: valid_city_name()
      })
      |> Atmanirbhar.Accounts.register_user()


    user
  end

  def extract_user_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.body, "[TOKEN]")
    token
  end
end
