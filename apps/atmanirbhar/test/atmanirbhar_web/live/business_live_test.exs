defmodule AtmanirbharWeb.BusinessLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Atmanirbhar.Marketplace

  @create_attrs %{address: "some address", description: "some description", power_index: 42, title: "some title"}
  @update_attrs %{address: "some updated address", description: "some updated description", power_index: 43, title: "some updated title"}
  @invalid_attrs %{address: nil, description: nil, power_index: nil, title: nil}

  defp fixture(:business) do
    {:ok, business} = Marketplace.create_business(@create_attrs)
    business
  end

  defp create_business(_) do
    business = fixture(:business)
    %{business: business}
  end

  describe "Index" do
    setup [:create_business]

    test "lists all businesses", %{conn: conn, business: business} do
      {:ok, _index_live, html} = live(conn, Routes.business_index_path(conn, :index))

      assert html =~ "Listing Businesses"
      assert html =~ business.address
    end

    test "saves new business", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.business_index_path(conn, :index))

      assert index_live |> element("a", "New Business") |> render_click() =~
               "New Business"

      assert_patch(index_live, Routes.business_index_path(conn, :new))

      assert index_live
             |> form("#business-form", business: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#business-form", business: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.business_index_path(conn, :index))

      assert html =~ "Business created successfully"
      assert html =~ "some address"
    end

    test "updates business in listing", %{conn: conn, business: business} do
      {:ok, index_live, _html} = live(conn, Routes.business_index_path(conn, :index))

      assert index_live |> element("#business-#{business.id} a", "Edit") |> render_click() =~
               "Edit Business"

      assert_patch(index_live, Routes.business_index_path(conn, :edit, business))

      assert index_live
             |> form("#business-form", business: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#business-form", business: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.business_index_path(conn, :index))

      assert html =~ "Business updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes business in listing", %{conn: conn, business: business} do
      {:ok, index_live, _html} = live(conn, Routes.business_index_path(conn, :index))

      assert index_live |> element("#business-#{business.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#business-#{business.id}")
    end
  end

  describe "Show" do
    setup [:create_business]

    test "displays business", %{conn: conn, business: business} do
      {:ok, _show_live, html} = live(conn, Routes.business_show_path(conn, :show, business))

      assert html =~ "Show Business"
      assert html =~ business.address
    end

    test "updates business within modal", %{conn: conn, business: business} do
      {:ok, show_live, _html} = live(conn, Routes.business_show_path(conn, :show, business))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Business"

      assert_patch(show_live, Routes.business_show_path(conn, :edit, business))

      assert show_live
             |> form("#business-form", business: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#business-form", business: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.business_show_path(conn, :show, business))

      assert html =~ "Business updated successfully"
      assert html =~ "some updated address"
    end
  end
end
