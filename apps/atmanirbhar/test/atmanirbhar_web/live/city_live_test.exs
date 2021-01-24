defmodule AtmanirbharWeb.CityLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  # alias Atmanirbhar.Geo

  # @create_attrs %{description: "some description", name: "some name", name_hinndi: "some name_hinndi"}
  # @update_attrs %{description: "some updated description", name: "some updated name", name_hinndi: "some updated name_hinndi"}
  # @invalid_attrs %{description: nil, name: nil, name_hinndi: nil}

  # defp fixture(:city) do
  #   {:ok, city} = Geo.create_city(@create_attrs)
  #   city
  # end

  # defp create_city(_) do
  #   city = fixture(:city)
  #   %{city: city}
  # end

  # describe "Index" do
  #   setup [:create_city]

  #   test "lists all cities", %{conn: conn, city: city} do
  #     {:ok, _index_live, html} = live(conn, Routes.city_index_path(conn, :index))

  #     assert html =~ "Listing Cities"
  #     assert html =~ city.description
  #   end

  #   test "saves new city", %{conn: conn} do
  #     {:ok, index_live, _html} = live(conn, Routes.city_index_path(conn, :index))

  #     assert index_live |> element("a", "New City") |> render_click() =~
  #              "New City"

  #     assert_patch(index_live, Routes.city_index_path(conn, :new))

  #     assert index_live
  #            |> form("#city-form", city: @invalid_attrs)
  #            |> render_change() =~ "can&apos;t be blank"

  #     {:ok, _, html} =
  #       index_live
  #       |> form("#city-form", city: @create_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.city_index_path(conn, :index))

  #     assert html =~ "City created successfully"
  #     assert html =~ "some description"
  #   end

  #   test "updates city in listing", %{conn: conn, city: city} do
  #     {:ok, index_live, _html} = live(conn, Routes.city_index_path(conn, :index))

  #     assert index_live |> element("#city-#{city.id} a", "Edit") |> render_click() =~
  #              "Edit City"

  #     assert_patch(index_live, Routes.city_index_path(conn, :edit, city))

  #     assert index_live
  #            |> form("#city-form", city: @invalid_attrs)
  #            |> render_change() =~ "can&apos;t be blank"

  #     {:ok, _, html} =
  #       index_live
  #       |> form("#city-form", city: @update_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.city_index_path(conn, :index))

  #     assert html =~ "City updated successfully"
  #     assert html =~ "some updated description"
  #   end

  #   test "deletes city in listing", %{conn: conn, city: city} do
  #     {:ok, index_live, _html} = live(conn, Routes.city_index_path(conn, :index))

  #     assert index_live |> element("#city-#{city.id} a", "Delete") |> render_click()
  #     refute has_element?(index_live, "#city-#{city.id}")
  #   end
  # end

  # describe "Show" do
  #   setup [:create_city]

  #   test "displays city", %{conn: conn, city: city} do
  #     {:ok, _show_live, html} = live(conn, Routes.city_show_path(conn, :show, city))

  #     assert html =~ "Show City"
  #     assert html =~ city.description
  #   end

  #   test "updates city within modal", %{conn: conn, city: city} do
  #     {:ok, show_live, _html} = live(conn, Routes.city_show_path(conn, :show, city))

  #     assert show_live |> element("a", "Edit") |> render_click() =~
  #              "Edit City"

  #     assert_patch(show_live, Routes.city_show_path(conn, :edit, city))

  #     assert show_live
  #            |> form("#city-form", city: @invalid_attrs)
  #            |> render_change() =~ "can&apos;t be blank"

  #     {:ok, _, html} =
  #       show_live
  #       |> form("#city-form", city: @update_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.city_show_path(conn, :show, city))

  #     assert html =~ "City updated successfully"
  #     assert html =~ "some updated description"
  #   end
  # end
end
