defmodule AtmanirbharWeb.PincodeLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Atmanirbhar.Geo

  @create_attrs %{city: "some city", description: "some description", name: 42}
  @update_attrs %{city: "some updated city", description: "some updated description", name: 43}
  @invalid_attrs %{city: nil, description: nil, name: nil}

  defp fixture(:pincode) do
    {:ok, pincode} = Geo.create_pincode(@create_attrs)
    pincode
  end

  defp create_pincode(_) do
    pincode = fixture(:pincode)
    %{pincode: pincode}
  end

  describe "Index" do
    setup [:create_pincode]

    test "lists all pincodes", %{conn: conn, pincode: pincode} do
      {:ok, _index_live, html} = live(conn, Routes.pincode_index_path(conn, :index))

      assert html =~ "Listing Pincodes"
      assert html =~ pincode.city
    end

    test "saves new pincode", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.pincode_index_path(conn, :index))

      assert index_live |> element("a", "New Pincode") |> render_click() =~
               "New Pincode"

      assert_patch(index_live, Routes.pincode_index_path(conn, :new))

      assert index_live
             |> form("#pincode-form", pincode: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#pincode-form", pincode: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pincode_index_path(conn, :index))

      assert html =~ "Pincode created successfully"
      assert html =~ "some city"
    end

    test "updates pincode in listing", %{conn: conn, pincode: pincode} do
      {:ok, index_live, _html} = live(conn, Routes.pincode_index_path(conn, :index))

      assert index_live |> element("#pincode-#{pincode.id} a", "Edit") |> render_click() =~
               "Edit Pincode"

      assert_patch(index_live, Routes.pincode_index_path(conn, :edit, pincode))

      assert index_live
             |> form("#pincode-form", pincode: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#pincode-form", pincode: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pincode_index_path(conn, :index))

      assert html =~ "Pincode updated successfully"
      assert html =~ "some updated city"
    end

    test "deletes pincode in listing", %{conn: conn, pincode: pincode} do
      {:ok, index_live, _html} = live(conn, Routes.pincode_index_path(conn, :index))

      assert index_live |> element("#pincode-#{pincode.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#pincode-#{pincode.id}")
    end
  end

  describe "Show" do
    setup [:create_pincode]

    test "displays pincode", %{conn: conn, pincode: pincode} do
      {:ok, _show_live, html} = live(conn, Routes.pincode_show_path(conn, :show, pincode))

      assert html =~ "Show Pincode"
      assert html =~ pincode.city
    end

    test "updates pincode within modal", %{conn: conn, pincode: pincode} do
      {:ok, show_live, _html} = live(conn, Routes.pincode_show_path(conn, :show, pincode))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pincode"

      assert_patch(show_live, Routes.pincode_show_path(conn, :edit, pincode))

      assert show_live
             |> form("#pincode-form", pincode: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#pincode-form", pincode: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pincode_show_path(conn, :show, pincode))

      assert html =~ "Pincode updated successfully"
      assert html =~ "some updated city"
    end
  end
end
