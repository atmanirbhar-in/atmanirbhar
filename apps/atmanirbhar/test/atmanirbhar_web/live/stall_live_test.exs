defmodule AtmanirbharWeb.StallLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Atmanirbhar.Marketplace

  @create_attrs %{audience_average: 42, description: "some description", for_female: true, for_male: true, is_active: true, poster_image_url: "some poster_image_url", title: "some title"}
  @update_attrs %{audience_average: 43, description: "some updated description", for_female: false, for_male: false, is_active: false, poster_image_url: "some updated poster_image_url", title: "some updated title"}
  @invalid_attrs %{audience_average: nil, description: nil, for_female: nil, for_male: nil, is_active: nil, poster_image_url: nil, title: nil}

  defp fixture(:stall) do
    {:ok, stall} = Marketplace.create_stall(@create_attrs)
    stall
  end

  defp create_stall(_) do
    stall = fixture(:stall)
    %{stall: stall}
  end

  describe "Index" do
    setup [:create_stall]

    test "lists all marketplace_stalls", %{conn: conn, stall: stall} do
      {:ok, _index_live, html} = live(conn, Routes.stall_index_path(conn, :index))

      assert html =~ "Listing Marketplace stalls"
      assert html =~ stall.description
    end

    test "saves new stall", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.stall_index_path(conn, :index))

      assert index_live |> element("a", "New Stall") |> render_click() =~
               "New Stall"

      assert_patch(index_live, Routes.stall_index_path(conn, :new))

      assert index_live
             |> form("#stall-form", stall: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#stall-form", stall: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.stall_index_path(conn, :index))

      assert html =~ "Stall created successfully"
      assert html =~ "some description"
    end

    test "updates stall in listing", %{conn: conn, stall: stall} do
      {:ok, index_live, _html} = live(conn, Routes.stall_index_path(conn, :index))

      assert index_live |> element("#stall-#{stall.id} a", "Edit") |> render_click() =~
               "Edit Stall"

      assert_patch(index_live, Routes.stall_index_path(conn, :edit, stall))

      assert index_live
             |> form("#stall-form", stall: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#stall-form", stall: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.stall_index_path(conn, :index))

      assert html =~ "Stall updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes stall in listing", %{conn: conn, stall: stall} do
      {:ok, index_live, _html} = live(conn, Routes.stall_index_path(conn, :index))

      assert index_live |> element("#stall-#{stall.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#stall-#{stall.id}")
    end
  end

  describe "Show" do
    setup [:create_stall]

    test "displays stall", %{conn: conn, stall: stall} do
      {:ok, _show_live, html} = live(conn, Routes.stall_show_path(conn, :show, stall))

      assert html =~ "Show Stall"
      assert html =~ stall.description
    end

    test "updates stall within modal", %{conn: conn, stall: stall} do
      {:ok, show_live, _html} = live(conn, Routes.stall_show_path(conn, :show, stall))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Stall"

      assert_patch(show_live, Routes.stall_show_path(conn, :edit, stall))

      assert show_live
             |> form("#stall-form", stall: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#stall-form", stall: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.stall_show_path(conn, :show, stall))

      assert html =~ "Stall updated successfully"
      assert html =~ "some updated description"
    end
  end
end
