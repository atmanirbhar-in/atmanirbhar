defmodule AtmanirbharWeb.TaxonomyLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  # alias Atmanirbhar.Catalog

  # @create_attrs %{full_name: "some full_name", is_visible: true, name: "some name", parent_uniq: 42, uniq: 42}
  # @update_attrs %{full_name: "some updated full_name", is_visible: false, name: "some updated name", parent_uniq: 43, uniq: 43}
  # @invalid_attrs %{full_name: nil, is_visible: nil, name: nil, parent_uniq: nil, uniq: nil}

  # defp fixture(:taxonomy) do
  #   {:ok, taxonomy} = Catalog.create_taxonomy(@create_attrs)
  #   taxonomy
  # end

  # defp create_taxonomy(_) do
  #   taxonomy = fixture(:taxonomy)
  #   %{taxonomy: taxonomy}
  # end

  # describe "Index" do
  #   setup [:create_taxonomy]

  #   test "lists all catalog_taxonomies", %{conn: conn, taxonomy: taxonomy} do
  #     {:ok, _index_live, html} = live(conn, Routes.taxonomy_index_path(conn, :index))

  #     assert html =~ "Listing Catalog taxonomies"
  #     assert html =~ taxonomy.full_name
  #   end

  #   test "saves new taxonomy", %{conn: conn} do
  #     {:ok, index_live, _html} = live(conn, Routes.taxonomy_index_path(conn, :index))

  #     assert index_live |> element("a", "New Taxonomy") |> render_click() =~
  #              "New Taxonomy"

  #     assert_patch(index_live, Routes.taxonomy_index_path(conn, :new))

  #     assert index_live
  #            |> form("#taxonomy-form", taxonomy: @invalid_attrs)
  #            |> render_change() =~ "can&apos;t be blank"

  #     {:ok, _, html} =
  #       index_live
  #       |> form("#taxonomy-form", taxonomy: @create_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.taxonomy_index_path(conn, :index))

  #     assert html =~ "Taxonomy created successfully"
  #     assert html =~ "some full_name"
  #   end

  #   test "updates taxonomy in listing", %{conn: conn, taxonomy: taxonomy} do
  #     {:ok, index_live, _html} = live(conn, Routes.taxonomy_index_path(conn, :index))

  #     assert index_live |> element("#taxonomy-#{taxonomy.id} a", "Edit") |> render_click() =~
  #              "Edit Taxonomy"

  #     assert_patch(index_live, Routes.taxonomy_index_path(conn, :edit, taxonomy))

  #     assert index_live
  #            |> form("#taxonomy-form", taxonomy: @invalid_attrs)
  #            |> render_change() =~ "can&apos;t be blank"

  #     {:ok, _, html} =
  #       index_live
  #       |> form("#taxonomy-form", taxonomy: @update_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.taxonomy_index_path(conn, :index))

  #     assert html =~ "Taxonomy updated successfully"
  #     assert html =~ "some updated full_name"
  #   end

  #   test "deletes taxonomy in listing", %{conn: conn, taxonomy: taxonomy} do
  #     {:ok, index_live, _html} = live(conn, Routes.taxonomy_index_path(conn, :index))

  #     assert index_live |> element("#taxonomy-#{taxonomy.id} a", "Delete") |> render_click()
  #     refute has_element?(index_live, "#taxonomy-#{taxonomy.id}")
  #   end
  # end

  # describe "Show" do
  #   setup [:create_taxonomy]

  #   test "displays taxonomy", %{conn: conn, taxonomy: taxonomy} do
  #     {:ok, _show_live, html} = live(conn, Routes.taxonomy_show_path(conn, :show, taxonomy))

  #     assert html =~ "Show Taxonomy"
  #     assert html =~ taxonomy.full_name
  #   end

  #   test "updates taxonomy within modal", %{conn: conn, taxonomy: taxonomy} do
  #     {:ok, show_live, _html} = live(conn, Routes.taxonomy_show_path(conn, :show, taxonomy))

  #     assert show_live |> element("a", "Edit") |> render_click() =~
  #              "Edit Taxonomy"

  #     assert_patch(show_live, Routes.taxonomy_show_path(conn, :edit, taxonomy))

  #     assert show_live
  #            |> form("#taxonomy-form", taxonomy: @invalid_attrs)
  #            |> render_change() =~ "can&apos;t be blank"

  #     {:ok, _, html} =
  #       show_live
  #       |> form("#taxonomy-form", taxonomy: @update_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.taxonomy_show_path(conn, :show, taxonomy))

  #     assert html =~ "Taxonomy updated successfully"
  #     assert html =~ "some updated full_name"
  #   end
  # end
end
