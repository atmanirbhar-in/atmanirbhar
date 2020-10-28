defmodule AtmanirbharWeb.RawMaterialLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Atmanirbhar.Resources

  @create_attrs %{category_id: "some category_id", name: "some name", package_quantity: "some package_quantity", picture_url: "some picture_url", price: "some price", seller_id: "some seller_id"}
  @update_attrs %{category_id: "some updated category_id", name: "some updated name", package_quantity: "some updated package_quantity", picture_url: "some updated picture_url", price: "some updated price", seller_id: "some updated seller_id"}
  @invalid_attrs %{category_id: nil, name: nil, package_quantity: nil, picture_url: nil, price: nil, seller_id: nil}

  defp fixture(:raw_material) do
    {:ok, raw_material} = Resources.create_raw_material(@create_attrs)
    raw_material
  end

  defp create_raw_material(_) do
    raw_material = fixture(:raw_material)
    %{raw_material: raw_material}
  end

  describe "Index" do
    setup [:create_raw_material]

    test "lists all raw_materials", %{conn: conn, raw_material: raw_material} do
      {:ok, _index_live, html} = live(conn, Routes.raw_material_index_path(conn, :index))

      assert html =~ "Listing Raw materials"
      assert html =~ raw_material.category_id
    end

    test "saves new raw_material", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.raw_material_index_path(conn, :index))

      assert index_live |> element("a", "New Raw material") |> render_click() =~
               "New Raw material"

      assert_patch(index_live, Routes.raw_material_index_path(conn, :new))

      assert index_live
             |> form("#raw_material-form", raw_material: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#raw_material-form", raw_material: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.raw_material_index_path(conn, :index))

      assert html =~ "Raw material created successfully"
      assert html =~ "some category_id"
    end

    test "updates raw_material in listing", %{conn: conn, raw_material: raw_material} do
      {:ok, index_live, _html} = live(conn, Routes.raw_material_index_path(conn, :index))

      assert index_live |> element("#raw_material-#{raw_material.id} a", "Edit") |> render_click() =~
               "Edit Raw material"

      assert_patch(index_live, Routes.raw_material_index_path(conn, :edit, raw_material))

      assert index_live
             |> form("#raw_material-form", raw_material: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#raw_material-form", raw_material: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.raw_material_index_path(conn, :index))

      assert html =~ "Raw material updated successfully"
      assert html =~ "some updated category_id"
    end

    test "deletes raw_material in listing", %{conn: conn, raw_material: raw_material} do
      {:ok, index_live, _html} = live(conn, Routes.raw_material_index_path(conn, :index))

      assert index_live |> element("#raw_material-#{raw_material.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#raw_material-#{raw_material.id}")
    end
  end

  describe "Show" do
    setup [:create_raw_material]

    test "displays raw_material", %{conn: conn, raw_material: raw_material} do
      {:ok, _show_live, html} = live(conn, Routes.raw_material_show_path(conn, :show, raw_material))

      assert html =~ "Show Raw material"
      assert html =~ raw_material.category_id
    end

    test "updates raw_material within modal", %{conn: conn, raw_material: raw_material} do
      {:ok, show_live, _html} = live(conn, Routes.raw_material_show_path(conn, :show, raw_material))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Raw material"

      assert_patch(show_live, Routes.raw_material_show_path(conn, :edit, raw_material))

      assert show_live
             |> form("#raw_material-form", raw_material: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#raw_material-form", raw_material: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.raw_material_show_path(conn, :show, raw_material))

      assert html =~ "Raw material updated successfully"
      assert html =~ "some updated category_id"
    end
  end
end
