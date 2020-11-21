defmodule AtmanirbharWeb.BulkUploadLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Atmanirbhar.Marketplace

  @create_attrs %{city_name: "some city_name", content_description: "some content_description", file_url: "some file_url", location_name: "some location_name", processesed_flag: true}
  @update_attrs %{city_name: "some updated city_name", content_description: "some updated content_description", file_url: "some updated file_url", location_name: "some updated location_name", processesed_flag: false}
  @invalid_attrs %{city_name: nil, content_description: nil, file_url: nil, location_name: nil, processesed_flag: nil}

  defp fixture(:bulk_upload) do
    {:ok, bulk_upload} = Marketplace.create_bulk_upload(@create_attrs)
    bulk_upload
  end

  defp create_bulk_upload(_) do
    bulk_upload = fixture(:bulk_upload)
    %{bulk_upload: bulk_upload}
  end

  describe "Index" do
    setup [:create_bulk_upload]

    test "lists all marketplace_bulk_uploads", %{conn: conn, bulk_upload: bulk_upload} do
      {:ok, _index_live, html} = live(conn, Routes.bulk_upload_index_path(conn, :index))

      assert html =~ "Listing Marketplace bulk uploads"
      assert html =~ bulk_upload.city_name
    end

    test "saves new bulk_upload", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bulk_upload_index_path(conn, :index))

      assert index_live |> element("a", "New Bulk upload") |> render_click() =~
               "New Bulk upload"

      assert_patch(index_live, Routes.bulk_upload_index_path(conn, :new))

      assert index_live
             |> form("#bulk_upload-form", bulk_upload: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bulk_upload-form", bulk_upload: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bulk_upload_index_path(conn, :index))

      assert html =~ "Bulk upload created successfully"
      assert html =~ "some city_name"
    end

    test "updates bulk_upload in listing", %{conn: conn, bulk_upload: bulk_upload} do
      {:ok, index_live, _html} = live(conn, Routes.bulk_upload_index_path(conn, :index))

      assert index_live |> element("#bulk_upload-#{bulk_upload.id} a", "Edit") |> render_click() =~
               "Edit Bulk upload"

      assert_patch(index_live, Routes.bulk_upload_index_path(conn, :edit, bulk_upload))

      assert index_live
             |> form("#bulk_upload-form", bulk_upload: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bulk_upload-form", bulk_upload: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bulk_upload_index_path(conn, :index))

      assert html =~ "Bulk upload updated successfully"
      assert html =~ "some updated city_name"
    end

    test "deletes bulk_upload in listing", %{conn: conn, bulk_upload: bulk_upload} do
      {:ok, index_live, _html} = live(conn, Routes.bulk_upload_index_path(conn, :index))

      assert index_live |> element("#bulk_upload-#{bulk_upload.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bulk_upload-#{bulk_upload.id}")
    end
  end

  describe "Show" do
    setup [:create_bulk_upload]

    test "displays bulk_upload", %{conn: conn, bulk_upload: bulk_upload} do
      {:ok, _show_live, html} = live(conn, Routes.bulk_upload_show_path(conn, :show, bulk_upload))

      assert html =~ "Show Bulk upload"
      assert html =~ bulk_upload.city_name
    end

    test "updates bulk_upload within modal", %{conn: conn, bulk_upload: bulk_upload} do
      {:ok, show_live, _html} = live(conn, Routes.bulk_upload_show_path(conn, :show, bulk_upload))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bulk upload"

      assert_patch(show_live, Routes.bulk_upload_show_path(conn, :edit, bulk_upload))

      assert show_live
             |> form("#bulk_upload-form", bulk_upload: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#bulk_upload-form", bulk_upload: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bulk_upload_show_path(conn, :show, bulk_upload))

      assert html =~ "Bulk upload updated successfully"
      assert html =~ "some updated city_name"
    end
  end
end
