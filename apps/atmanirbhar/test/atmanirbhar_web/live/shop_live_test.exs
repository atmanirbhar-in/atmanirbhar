defmodule AtmanirbharWeb.ShopLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Atmanirbhar.Marketplace

  @create_attrs %{description: "some description", name: "some name", name_hindi: "some name_hindi"}
  @update_attrs %{description: "some updated description", name: "some updated name", name_hindi: "some updated name_hindi"}
  @invalid_attrs %{description: nil, name: nil, name_hindi: nil}

  defp fixture(:shop) do
    {:ok, shop} = Marketplace.create_shop(@create_attrs)
    shop
  end

  defp create_shop(_) do
    shop = fixture(:shop)
    %{shop: shop}
  end

  describe "Index" do
    setup [:create_shop]

    test "lists all shops", %{conn: conn, shop: shop} do
      {:ok, _index_live, html} = live(conn, Routes.shop_index_path(conn, :index))

      assert html =~ "Listing Shops"
      assert html =~ shop.description
    end

    test "saves new shop", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.shop_index_path(conn, :index))

      assert index_live |> element("a", "New Shop") |> render_click() =~
               "New Shop"

      assert_patch(index_live, Routes.shop_index_path(conn, :new))

      assert index_live
             |> form("#shop-form", shop: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#shop-form", shop: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.shop_index_path(conn, :index))

      assert html =~ "Shop created successfully"
      assert html =~ "some description"
    end

    test "updates shop in listing", %{conn: conn, shop: shop} do
      {:ok, index_live, _html} = live(conn, Routes.shop_index_path(conn, :index))

      assert index_live |> element("#shop-#{shop.id} a", "Edit") |> render_click() =~
               "Edit Shop"

      assert_patch(index_live, Routes.shop_index_path(conn, :edit, shop))

      assert index_live
             |> form("#shop-form", shop: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#shop-form", shop: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.shop_index_path(conn, :index))

      assert html =~ "Shop updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes shop in listing", %{conn: conn, shop: shop} do
      {:ok, index_live, _html} = live(conn, Routes.shop_index_path(conn, :index))

      assert index_live |> element("#shop-#{shop.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#shop-#{shop.id}")
    end
  end

  describe "Show" do
    setup [:create_shop]

    test "displays shop", %{conn: conn, shop: shop} do
      {:ok, _show_live, html} = live(conn, Routes.shop_show_path(conn, :show, shop))

      assert html =~ "Show Shop"
      assert html =~ shop.description
    end

    test "updates shop within modal", %{conn: conn, shop: shop} do
      {:ok, show_live, _html} = live(conn, Routes.shop_show_path(conn, :show, shop))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Shop"

      assert_patch(show_live, Routes.shop_show_path(conn, :edit, shop))

      assert show_live
             |> form("#shop-form", shop: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#shop-form", shop: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.shop_show_path(conn, :show, shop))

      assert html =~ "Shop updated successfully"
      assert html =~ "some updated description"
    end
  end
end
