defmodule AtmanirbharWeb.BlueprintLiveTest do
  use AtmanirbharWeb.ConnCase

  import Phoenix.LiveViewTest

  # alias Atmanirbhar.Catalog

  # @create_attrs %{blueprint_code: "some blueprint_code", description_hint: "some description_hint", search_terms: "some search_terms", taxonomy: "some taxonomy", title: "some title"}
  # @update_attrs %{blueprint_code: "some updated blueprint_code", description_hint: "some updated description_hint", search_terms: "some updated search_terms", taxonomy: "some updated taxonomy", title: "some updated title"}
  # @invalid_attrs %{blueprint_code: nil, description_hint: nil, search_terms: nil, taxonomy: nil, title: nil}

  # defp fixture(:blueprint) do
  #   {:ok, blueprint} = Catalog.create_blueprint(@create_attrs)
  #   blueprint
  # end

  # defp create_blueprint(_) do
  #   blueprint = fixture(:blueprint)
  #   %{blueprint: blueprint}
  # end

  # describe "Index" do
  #   setup [:create_blueprint]

  #   test "lists all catalog_blueprints", %{conn: conn, blueprint: blueprint} do
  #     {:ok, _index_live, html} = live(conn, Routes.blueprint_index_path(conn, :index))

  #     assert html =~ "Listing Catalog blueprints"
  #     assert html =~ blueprint.blueprint_code
  #   end

  #   test "saves new blueprint", %{conn: conn} do
  #     {:ok, index_live, _html} = live(conn, Routes.blueprint_index_path(conn, :index))

  #     assert index_live |> element("a", "New Blueprint") |> render_click() =~
  #              "New Blueprint"

  #     assert_patch(index_live, Routes.blueprint_index_path(conn, :new))

  #     assert index_live
  #            |> form("#blueprint-form", blueprint: @invalid_attrs)
  #            |> render_change() =~ "can&apos;t be blank"

  #     {:ok, _, html} =
  #       index_live
  #       |> form("#blueprint-form", blueprint: @create_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.blueprint_index_path(conn, :index))

  #     assert html =~ "Blueprint created successfully"
  #     assert html =~ "some blueprint_code"
  #   end

  #   test "updates blueprint in listing", %{conn: conn, blueprint: blueprint} do
  #     {:ok, index_live, _html} = live(conn, Routes.blueprint_index_path(conn, :index))

  #     assert index_live |> element("#blueprint-#{blueprint.id} a", "Edit") |> render_click() =~
  #              "Edit Blueprint"

  #     assert_patch(index_live, Routes.blueprint_index_path(conn, :edit, blueprint))

  #     assert index_live
  #            |> form("#blueprint-form", blueprint: @invalid_attrs)
  #            |> render_change() =~ "can&apos;t be blank"

  #     {:ok, _, html} =
  #       index_live
  #       |> form("#blueprint-form", blueprint: @update_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.blueprint_index_path(conn, :index))

  #     assert html =~ "Blueprint updated successfully"
  #     assert html =~ "some updated blueprint_code"
  #   end

  #   test "deletes blueprint in listing", %{conn: conn, blueprint: blueprint} do
  #     {:ok, index_live, _html} = live(conn, Routes.blueprint_index_path(conn, :index))

  #     assert index_live |> element("#blueprint-#{blueprint.id} a", "Delete") |> render_click()
  #     refute has_element?(index_live, "#blueprint-#{blueprint.id}")
  #   end
  # end

  # describe "Show" do
  #   setup [:create_blueprint]

  #   test "displays blueprint", %{conn: conn, blueprint: blueprint} do
  #     {:ok, _show_live, html} = live(conn, Routes.blueprint_show_path(conn, :show, blueprint))

  #     assert html =~ "Show Blueprint"
  #     assert html =~ blueprint.blueprint_code
  #   end

  #   test "updates blueprint within modal", %{conn: conn, blueprint: blueprint} do
  #     {:ok, show_live, _html} = live(conn, Routes.blueprint_show_path(conn, :show, blueprint))

  #     assert show_live |> element("a", "Edit") |> render_click() =~
  #              "Edit Blueprint"

  #     assert_patch(show_live, Routes.blueprint_show_path(conn, :edit, blueprint))

  #     assert show_live
  #            |> form("#blueprint-form", blueprint: @invalid_attrs)
  #            |> render_change() =~ "can&apos;t be blank"

  #     {:ok, _, html} =
  #       show_live
  #       |> form("#blueprint-form", blueprint: @update_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.blueprint_show_path(conn, :show, blueprint))

  #     assert html =~ "Blueprint updated successfully"
  #     assert html =~ "some updated blueprint_code"
  #   end
  # end
end
