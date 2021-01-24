defmodule Atmanirbhar.CatalogTest do
  use Atmanirbhar.DataCase

  alias Atmanirbhar.Catalog

  # describe "catalog_blueprints" do
  #   alias Atmanirbhar.Catalog.Blueprint

  #   @valid_attrs %{blueprint_code: "some blueprint_code", description_hint: "some description_hint", search_terms: "some search_terms", taxonomy: "some taxonomy", title: "some title"}
  #   @update_attrs %{blueprint_code: "some updated blueprint_code", description_hint: "some updated description_hint", search_terms: "some updated search_terms", taxonomy: "some updated taxonomy", title: "some updated title"}
  #   @invalid_attrs %{blueprint_code: nil, description_hint: nil, search_terms: nil, taxonomy: nil, title: nil}

  #   def blueprint_fixture(attrs \\ %{}) do
  #     {:ok, blueprint} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Catalog.create_blueprint()

  #     blueprint
  #   end

  #   test "list_catalog_blueprints/0 returns all catalog_blueprints" do
  #     blueprint = blueprint_fixture()
  #     assert Catalog.list_catalog_blueprints() == [blueprint]
  #   end

  #   test "get_blueprint!/1 returns the blueprint with given id" do
  #     blueprint = blueprint_fixture()
  #     assert Catalog.get_blueprint!(blueprint.id) == blueprint
  #   end

  #   test "create_blueprint/1 with valid data creates a blueprint" do
  #     assert {:ok, %Blueprint{} = blueprint} = Catalog.create_blueprint(@valid_attrs)
  #     assert blueprint.blueprint_code == "some blueprint_code"
  #     assert blueprint.description_hint == "some description_hint"
  #     assert blueprint.search_terms == "some search_terms"
  #     assert blueprint.taxonomy == "some taxonomy"
  #     assert blueprint.title == "some title"
  #   end

  #   test "create_blueprint/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Catalog.create_blueprint(@invalid_attrs)
  #   end

  #   test "update_blueprint/2 with valid data updates the blueprint" do
  #     blueprint = blueprint_fixture()
  #     assert {:ok, %Blueprint{} = blueprint} = Catalog.update_blueprint(blueprint, @update_attrs)
  #     assert blueprint.blueprint_code == "some updated blueprint_code"
  #     assert blueprint.description_hint == "some updated description_hint"
  #     assert blueprint.search_terms == "some updated search_terms"
  #     assert blueprint.taxonomy == "some updated taxonomy"
  #     assert blueprint.title == "some updated title"
  #   end

  #   test "update_blueprint/2 with invalid data returns error changeset" do
  #     blueprint = blueprint_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Catalog.update_blueprint(blueprint, @invalid_attrs)
  #     assert blueprint == Catalog.get_blueprint!(blueprint.id)
  #   end

  #   test "delete_blueprint/1 deletes the blueprint" do
  #     blueprint = blueprint_fixture()
  #     assert {:ok, %Blueprint{}} = Catalog.delete_blueprint(blueprint)
  #     assert_raise Ecto.NoResultsError, fn -> Catalog.get_blueprint!(blueprint.id) end
  #   end

  #   test "change_blueprint/1 returns a blueprint changeset" do
  #     blueprint = blueprint_fixture()
  #     assert %Ecto.Changeset{} = Catalog.change_blueprint(blueprint)
  #   end
  # end

  # describe "catalog_taxonomies" do
  #   alias Atmanirbhar.Catalog.Taxonomy

  #   @valid_attrs %{full_name: "some full_name", is_visible: true, name: "some name", parent_uniq: 42, uniq: 42}
  #   @update_attrs %{full_name: "some updated full_name", is_visible: false, name: "some updated name", parent_uniq: 43, uniq: 43}
  #   @invalid_attrs %{full_name: nil, is_visible: nil, name: nil, parent_uniq: nil, uniq: nil}

  #   def taxonomy_fixture(attrs \\ %{}) do
  #     {:ok, taxonomy} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Catalog.create_taxonomy()

  #     taxonomy
  #   end

  #   test "list_catalog_taxonomies/0 returns all catalog_taxonomies" do
  #     taxonomy = taxonomy_fixture()
  #     assert Catalog.list_catalog_taxonomies() == [taxonomy]
  #   end

  #   test "get_taxonomy!/1 returns the taxonomy with given id" do
  #     taxonomy = taxonomy_fixture()
  #     assert Catalog.get_taxonomy!(taxonomy.id) == taxonomy
  #   end

  #   test "create_taxonomy/1 with valid data creates a taxonomy" do
  #     assert {:ok, %Taxonomy{} = taxonomy} = Catalog.create_taxonomy(@valid_attrs)
  #     assert taxonomy.full_name == "some full_name"
  #     assert taxonomy.is_visible == true
  #     assert taxonomy.name == "some name"
  #     assert taxonomy.parent_uniq == 42
  #     assert taxonomy.uniq == 42
  #   end

  #   test "create_taxonomy/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Catalog.create_taxonomy(@invalid_attrs)
  #   end

  #   test "update_taxonomy/2 with valid data updates the taxonomy" do
  #     taxonomy = taxonomy_fixture()
  #     assert {:ok, %Taxonomy{} = taxonomy} = Catalog.update_taxonomy(taxonomy, @update_attrs)
  #     assert taxonomy.full_name == "some updated full_name"
  #     assert taxonomy.is_visible == false
  #     assert taxonomy.name == "some updated name"
  #     assert taxonomy.parent_uniq == 43
  #     assert taxonomy.uniq == 43
  #   end

  #   test "update_taxonomy/2 with invalid data returns error changeset" do
  #     taxonomy = taxonomy_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Catalog.update_taxonomy(taxonomy, @invalid_attrs)
  #     assert taxonomy == Catalog.get_taxonomy!(taxonomy.id)
  #   end

  #   test "delete_taxonomy/1 deletes the taxonomy" do
  #     taxonomy = taxonomy_fixture()
  #     assert {:ok, %Taxonomy{}} = Catalog.delete_taxonomy(taxonomy)
  #     assert_raise Ecto.NoResultsError, fn -> Catalog.get_taxonomy!(taxonomy.id) end
  #   end

  #   test "change_taxonomy/1 returns a taxonomy changeset" do
  #     taxonomy = taxonomy_fixture()
  #     assert %Ecto.Changeset{} = Catalog.change_taxonomy(taxonomy)
  #   end
  # end
end
