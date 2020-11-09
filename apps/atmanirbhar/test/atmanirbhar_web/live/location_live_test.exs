defmodule AtmanirbharWeb.LocationLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Atmanirbhar.Geo

  @create_attrs %{match_slugs: [], nearby_slugs: [], slug: "some slug", title: "some title"}
  @update_attrs %{match_slugs: [], nearby_slugs: [], slug: "some updated slug", title: "some updated title"}
  @invalid_attrs %{match_slugs: nil, nearby_slugs: nil, slug: nil, title: nil}

  defp fixture(:location) do
    {:ok, location} = Geo.create_location(@create_attrs)
    location
  end

  defp create_location(_) do
    location = fixture(:location)
    %{location: location}
  end

  describe "Index" do
    setup [:create_location]

    test "lists all locations", %{conn: conn, location: location} do
      {:ok, _index_live, html} = live(conn, Routes.location_index_path(conn, :index))

      assert html =~ "Listing Locations"
      assert html =~ location.match_slugs
    end

    test "saves new location", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.location_index_path(conn, :index))

      assert index_live |> element("a", "New Location") |> render_click() =~
               "New Location"

      assert_patch(index_live, Routes.location_index_path(conn, :new))

      assert index_live
             |> form("#location-form", location: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#location-form", location: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.location_index_path(conn, :index))

      assert html =~ "Location created successfully"
      assert html =~ "some match_slugs"
    end

    test "updates location in listing", %{conn: conn, location: location} do
      {:ok, index_live, _html} = live(conn, Routes.location_index_path(conn, :index))

      assert index_live |> element("#location-#{location.id} a", "Edit") |> render_click() =~
               "Edit Location"

      assert_patch(index_live, Routes.location_index_path(conn, :edit, location))

      assert index_live
             |> form("#location-form", location: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#location-form", location: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.location_index_path(conn, :index))

      assert html =~ "Location updated successfully"
      assert html =~ "some updated match_slugs"
    end

    test "deletes location in listing", %{conn: conn, location: location} do
      {:ok, index_live, _html} = live(conn, Routes.location_index_path(conn, :index))

      assert index_live |> element("#location-#{location.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#location-#{location.id}")
    end
  end

  describe "Show" do
    setup [:create_location]

    test "displays location", %{conn: conn, location: location} do
      {:ok, _show_live, html} = live(conn, Routes.location_show_path(conn, :show, location))

      assert html =~ "Show Location"
      assert html =~ location.match_slugs
    end

    test "updates location within modal", %{conn: conn, location: location} do
      {:ok, show_live, _html} = live(conn, Routes.location_show_path(conn, :show, location))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Location"

      assert_patch(show_live, Routes.location_show_path(conn, :edit, location))

      assert show_live
             |> form("#location-form", location: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#location-form", location: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.location_show_path(conn, :show, location))

      assert html =~ "Location updated successfully"
      assert html =~ "some updated match_slugs"
    end
  end
end
