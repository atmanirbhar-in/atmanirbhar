defmodule AtmanirbharWeb.DealsLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Atmanirbhar.Marketplace

  @create_attrs %{date: ~D[2010-04-17], price: 42, status: 42}
  @update_attrs %{date: ~D[2011-05-18], price: 43, status: 43}
  @invalid_attrs %{date: nil, price: nil, status: nil}

  defp fixture(:deals) do
    {:ok, deals} = Marketplace.create_deals(@create_attrs)
    deals
  end

  defp create_deals(_) do
    deals = fixture(:deals)
    %{deals: deals}
  end

  describe "Index" do
    setup [:create_deals]

    test "lists all marketplace_products_deals", %{conn: conn, deals: deals} do
      {:ok, _index_live, html} = live(conn, Routes.deals_index_path(conn, :index))

      assert html =~ "Listing Marketplace products deals"
    end

    test "saves new deals", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.deals_index_path(conn, :index))

      assert index_live |> element("a", "New Deals") |> render_click() =~
               "New Deals"

      assert_patch(index_live, Routes.deals_index_path(conn, :new))

      assert index_live
             |> form("#deals-form", deals: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#deals-form", deals: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deals_index_path(conn, :index))

      assert html =~ "Deals created successfully"
    end

    test "updates deals in listing", %{conn: conn, deals: deals} do
      {:ok, index_live, _html} = live(conn, Routes.deals_index_path(conn, :index))

      assert index_live |> element("#deals-#{deals.id} a", "Edit") |> render_click() =~
               "Edit Deals"

      assert_patch(index_live, Routes.deals_index_path(conn, :edit, deals))

      assert index_live
             |> form("#deals-form", deals: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#deals-form", deals: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deals_index_path(conn, :index))

      assert html =~ "Deals updated successfully"
    end

    test "deletes deals in listing", %{conn: conn, deals: deals} do
      {:ok, index_live, _html} = live(conn, Routes.deals_index_path(conn, :index))

      assert index_live |> element("#deals-#{deals.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#deals-#{deals.id}")
    end
  end

  describe "Show" do
    setup [:create_deals]

    test "displays deals", %{conn: conn, deals: deals} do
      {:ok, _show_live, html} = live(conn, Routes.deals_show_path(conn, :show, deals))

      assert html =~ "Show Deals"
    end

    test "updates deals within modal", %{conn: conn, deals: deals} do
      {:ok, show_live, _html} = live(conn, Routes.deals_show_path(conn, :show, deals))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Deals"

      assert_patch(show_live, Routes.deals_show_path(conn, :edit, deals))

      assert show_live
             |> form("#deals-form", deals: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#deals-form", deals: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deals_show_path(conn, :show, deals))

      assert html =~ "Deals updated successfully"
    end
  end
end
