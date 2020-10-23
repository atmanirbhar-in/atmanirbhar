defmodule AtmanirbharWeb.DealLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Atmanirbhar.Marketplace

  @create_attrs %{availability: "some availability", description: "some description", is_approved: true, name: "some name", name_hindi: "some name_hindi", price: 42}
  @update_attrs %{availability: "some updated availability", description: "some updated description", is_approved: false, name: "some updated name", name_hindi: "some updated name_hindi", price: 43}
  @invalid_attrs %{availability: nil, description: nil, is_approved: nil, name: nil, name_hindi: nil, price: nil}

  defp fixture(:deal) do
    {:ok, deal} = Marketplace.create_deal(@create_attrs)
    deal
  end

  defp create_deal(_) do
    deal = fixture(:deal)
    %{deal: deal}
  end

  describe "Index" do
    setup [:create_deal]

    test "lists all deals", %{conn: conn, deal: deal} do
      {:ok, _index_live, html} = live(conn, Routes.deal_index_path(conn, :index))

      assert html =~ "Listing Deals"
      assert html =~ deal.availability
    end

    test "saves new deal", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.deal_index_path(conn, :index))

      assert index_live |> element("a", "New Deal") |> render_click() =~
               "New Deal"

      assert_patch(index_live, Routes.deal_index_path(conn, :new))

      assert index_live
             |> form("#deal-form", deal: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#deal-form", deal: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deal_index_path(conn, :index))

      assert html =~ "Deal created successfully"
      assert html =~ "some availability"
    end

    test "updates deal in listing", %{conn: conn, deal: deal} do
      {:ok, index_live, _html} = live(conn, Routes.deal_index_path(conn, :index))

      assert index_live |> element("#deal-#{deal.id} a", "Edit") |> render_click() =~
               "Edit Deal"

      assert_patch(index_live, Routes.deal_index_path(conn, :edit, deal))

      assert index_live
             |> form("#deal-form", deal: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#deal-form", deal: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deal_index_path(conn, :index))

      assert html =~ "Deal updated successfully"
      assert html =~ "some updated availability"
    end

    test "deletes deal in listing", %{conn: conn, deal: deal} do
      {:ok, index_live, _html} = live(conn, Routes.deal_index_path(conn, :index))

      assert index_live |> element("#deal-#{deal.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#deal-#{deal.id}")
    end
  end

  describe "Show" do
    setup [:create_deal]

    test "displays deal", %{conn: conn, deal: deal} do
      {:ok, _show_live, html} = live(conn, Routes.deal_show_path(conn, :show, deal))

      assert html =~ "Show Deal"
      assert html =~ deal.availability
    end

    test "updates deal within modal", %{conn: conn, deal: deal} do
      {:ok, show_live, _html} = live(conn, Routes.deal_show_path(conn, :show, deal))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Deal"

      assert_patch(show_live, Routes.deal_show_path(conn, :edit, deal))

      assert show_live
             |> form("#deal-form", deal: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#deal-form", deal: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deal_show_path(conn, :show, deal))

      assert html =~ "Deal updated successfully"
      assert html =~ "some updated availability"
    end
  end
end
