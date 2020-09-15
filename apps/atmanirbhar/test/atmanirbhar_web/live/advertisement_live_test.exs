defmodule AtmanirbharWeb.AdvertisementLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Atmanirbhar.Marketplace

  @create_attrs %{availability: "some availability", description: "some description", is_approved: true, name: "some name", name_hindi: "some name_hindi", price: 42}
  @update_attrs %{availability: "some updated availability", description: "some updated description", is_approved: false, name: "some updated name", name_hindi: "some updated name_hindi", price: 43}
  @invalid_attrs %{availability: nil, description: nil, is_approved: nil, name: nil, name_hindi: nil, price: nil}

  defp fixture(:advertisement) do
    {:ok, advertisement} = Marketplace.create_advertisement(@create_attrs)
    advertisement
  end

  defp create_advertisement(_) do
    advertisement = fixture(:advertisement)
    %{advertisement: advertisement}
  end

  describe "Index" do
    setup [:create_advertisement]

    test "lists all advertisements", %{conn: conn, advertisement: advertisement} do
      {:ok, _index_live, html} = live(conn, Routes.advertisement_index_path(conn, :index))

      assert html =~ "Listing Advertisements"
      assert html =~ advertisement.availability
    end

    test "saves new advertisement", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.advertisement_index_path(conn, :index))

      assert index_live |> element("a", "New Advertisement") |> render_click() =~
               "New Advertisement"

      assert_patch(index_live, Routes.advertisement_index_path(conn, :new))

      assert index_live
             |> form("#advertisement-form", advertisement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#advertisement-form", advertisement: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.advertisement_index_path(conn, :index))

      assert html =~ "Advertisement created successfully"
      assert html =~ "some availability"
    end

    test "updates advertisement in listing", %{conn: conn, advertisement: advertisement} do
      {:ok, index_live, _html} = live(conn, Routes.advertisement_index_path(conn, :index))

      assert index_live |> element("#advertisement-#{advertisement.id} a", "Edit") |> render_click() =~
               "Edit Advertisement"

      assert_patch(index_live, Routes.advertisement_index_path(conn, :edit, advertisement))

      assert index_live
             |> form("#advertisement-form", advertisement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#advertisement-form", advertisement: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.advertisement_index_path(conn, :index))

      assert html =~ "Advertisement updated successfully"
      assert html =~ "some updated availability"
    end

    test "deletes advertisement in listing", %{conn: conn, advertisement: advertisement} do
      {:ok, index_live, _html} = live(conn, Routes.advertisement_index_path(conn, :index))

      assert index_live |> element("#advertisement-#{advertisement.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#advertisement-#{advertisement.id}")
    end
  end

  describe "Show" do
    setup [:create_advertisement]

    test "displays advertisement", %{conn: conn, advertisement: advertisement} do
      {:ok, _show_live, html} = live(conn, Routes.advertisement_show_path(conn, :show, advertisement))

      assert html =~ "Show Advertisement"
      assert html =~ advertisement.availability
    end

    test "updates advertisement within modal", %{conn: conn, advertisement: advertisement} do
      {:ok, show_live, _html} = live(conn, Routes.advertisement_show_path(conn, :show, advertisement))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Advertisement"

      assert_patch(show_live, Routes.advertisement_show_path(conn, :edit, advertisement))

      assert show_live
             |> form("#advertisement-form", advertisement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#advertisement-form", advertisement: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.advertisement_show_path(conn, :show, advertisement))

      assert html =~ "Advertisement updated successfully"
      assert html =~ "some updated availability"
    end
  end
end
