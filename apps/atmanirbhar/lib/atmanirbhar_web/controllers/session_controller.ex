defmodule AtmanirbharWeb.SessionController do
  use AtmanirbharWeb, :controller

  def set(conn, %{"pincode" => pincode}), do: store_string(conn, :pincode, pincode)
  def set(conn, %{"city" => city}), do: store_string(conn, :city, city)

  defp store_string(conn, key, value) do
    conn
    |> put_session(key, value)
    |> json("OK!")
  end

end
