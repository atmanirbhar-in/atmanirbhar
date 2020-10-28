defmodule Atmanirbhar.ResourcesTest do
  use Atmanirbhar.DataCase

  alias Atmanirbhar.Resources

  describe "raw_materials" do
    alias Atmanirbhar.Resources.RawMaterial

    @valid_attrs %{category_id: "some category_id", name: "some name", package_quantity: "some package_quantity", picture_url: "some picture_url", price: "some price", seller_id: "some seller_id"}
    @update_attrs %{category_id: "some updated category_id", name: "some updated name", package_quantity: "some updated package_quantity", picture_url: "some updated picture_url", price: "some updated price", seller_id: "some updated seller_id"}
    @invalid_attrs %{category_id: nil, name: nil, package_quantity: nil, picture_url: nil, price: nil, seller_id: nil}

    def raw_material_fixture(attrs \\ %{}) do
      {:ok, raw_material} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_raw_material()

      raw_material
    end

    test "list_raw_materials/0 returns all raw_materials" do
      raw_material = raw_material_fixture()
      assert Resources.list_raw_materials() == [raw_material]
    end

    test "get_raw_material!/1 returns the raw_material with given id" do
      raw_material = raw_material_fixture()
      assert Resources.get_raw_material!(raw_material.id) == raw_material
    end

    test "create_raw_material/1 with valid data creates a raw_material" do
      assert {:ok, %RawMaterial{} = raw_material} = Resources.create_raw_material(@valid_attrs)
      assert raw_material.category_id == "some category_id"
      assert raw_material.name == "some name"
      assert raw_material.package_quantity == "some package_quantity"
      assert raw_material.picture_url == "some picture_url"
      assert raw_material.price == "some price"
      assert raw_material.seller_id == "some seller_id"
    end

    test "create_raw_material/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_raw_material(@invalid_attrs)
    end

    test "update_raw_material/2 with valid data updates the raw_material" do
      raw_material = raw_material_fixture()
      assert {:ok, %RawMaterial{} = raw_material} = Resources.update_raw_material(raw_material, @update_attrs)
      assert raw_material.category_id == "some updated category_id"
      assert raw_material.name == "some updated name"
      assert raw_material.package_quantity == "some updated package_quantity"
      assert raw_material.picture_url == "some updated picture_url"
      assert raw_material.price == "some updated price"
      assert raw_material.seller_id == "some updated seller_id"
    end

    test "update_raw_material/2 with invalid data returns error changeset" do
      raw_material = raw_material_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_raw_material(raw_material, @invalid_attrs)
      assert raw_material == Resources.get_raw_material!(raw_material.id)
    end

    test "delete_raw_material/1 deletes the raw_material" do
      raw_material = raw_material_fixture()
      assert {:ok, %RawMaterial{}} = Resources.delete_raw_material(raw_material)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_raw_material!(raw_material.id) end
    end

    test "change_raw_material/1 returns a raw_material changeset" do
      raw_material = raw_material_fixture()
      assert %Ecto.Changeset{} = Resources.change_raw_material(raw_material)
    end
  end
end
