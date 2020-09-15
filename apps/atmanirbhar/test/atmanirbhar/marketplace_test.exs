defmodule Atmanirbhar.MarketplaceTest do
  use Atmanirbhar.DataCase

  alias Atmanirbhar.Marketplace

  describe "shops" do
    alias Atmanirbhar.Marketplace.Shop

    @valid_attrs %{description: "some description", name: "some name", name_hindi: "some name_hindi"}
    @update_attrs %{description: "some updated description", name: "some updated name", name_hindi: "some updated name_hindi"}
    @invalid_attrs %{description: nil, name: nil, name_hindi: nil}

    def shop_fixture(attrs \\ %{}) do
      {:ok, shop} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marketplace.create_shop()

      shop
    end

    test "list_shops/0 returns all shops" do
      shop = shop_fixture()
      assert Marketplace.list_shops() == [shop]
    end

    test "get_shop!/1 returns the shop with given id" do
      shop = shop_fixture()
      assert Marketplace.get_shop!(shop.id) == shop
    end

    test "create_shop/1 with valid data creates a shop" do
      assert {:ok, %Shop{} = shop} = Marketplace.create_shop(@valid_attrs)
      assert shop.description == "some description"
      assert shop.name == "some name"
      assert shop.name_hindi == "some name_hindi"
    end

    test "create_shop/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marketplace.create_shop(@invalid_attrs)
    end

    test "update_shop/2 with valid data updates the shop" do
      shop = shop_fixture()
      assert {:ok, %Shop{} = shop} = Marketplace.update_shop(shop, @update_attrs)
      assert shop.description == "some updated description"
      assert shop.name == "some updated name"
      assert shop.name_hindi == "some updated name_hindi"
    end

    test "update_shop/2 with invalid data returns error changeset" do
      shop = shop_fixture()
      assert {:error, %Ecto.Changeset{}} = Marketplace.update_shop(shop, @invalid_attrs)
      assert shop == Marketplace.get_shop!(shop.id)
    end

    test "delete_shop/1 deletes the shop" do
      shop = shop_fixture()
      assert {:ok, %Shop{}} = Marketplace.delete_shop(shop)
      assert_raise Ecto.NoResultsError, fn -> Marketplace.get_shop!(shop.id) end
    end

    test "change_shop/1 returns a shop changeset" do
      shop = shop_fixture()
      assert %Ecto.Changeset{} = Marketplace.change_shop(shop)
    end
  end

  describe "advertisements" do
    alias Atmanirbhar.Marketplace.Advertisement

    @valid_attrs %{availability: "some availability", description: "some description", is_approved: true, name: "some name", name_hindi: "some name_hindi", price: 42}
    @update_attrs %{availability: "some updated availability", description: "some updated description", is_approved: false, name: "some updated name", name_hindi: "some updated name_hindi", price: 43}
    @invalid_attrs %{availability: nil, description: nil, is_approved: nil, name: nil, name_hindi: nil, price: nil}

    def advertisement_fixture(attrs \\ %{}) do
      {:ok, advertisement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marketplace.create_advertisement()

      advertisement
    end

    test "list_advertisements/0 returns all advertisements" do
      advertisement = advertisement_fixture()
      assert Marketplace.list_advertisements() == [advertisement]
    end

    test "get_advertisement!/1 returns the advertisement with given id" do
      advertisement = advertisement_fixture()
      assert Marketplace.get_advertisement!(advertisement.id) == advertisement
    end

    test "create_advertisement/1 with valid data creates a advertisement" do
      assert {:ok, %Advertisement{} = advertisement} = Marketplace.create_advertisement(@valid_attrs)
      assert advertisement.availability == "some availability"
      assert advertisement.description == "some description"
      assert advertisement.is_approved == true
      assert advertisement.name == "some name"
      assert advertisement.name_hindi == "some name_hindi"
      assert advertisement.price == 42
    end

    test "create_advertisement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marketplace.create_advertisement(@invalid_attrs)
    end

    test "update_advertisement/2 with valid data updates the advertisement" do
      advertisement = advertisement_fixture()
      assert {:ok, %Advertisement{} = advertisement} = Marketplace.update_advertisement(advertisement, @update_attrs)
      assert advertisement.availability == "some updated availability"
      assert advertisement.description == "some updated description"
      assert advertisement.is_approved == false
      assert advertisement.name == "some updated name"
      assert advertisement.name_hindi == "some updated name_hindi"
      assert advertisement.price == 43
    end

    test "update_advertisement/2 with invalid data returns error changeset" do
      advertisement = advertisement_fixture()
      assert {:error, %Ecto.Changeset{}} = Marketplace.update_advertisement(advertisement, @invalid_attrs)
      assert advertisement == Marketplace.get_advertisement!(advertisement.id)
    end

    test "delete_advertisement/1 deletes the advertisement" do
      advertisement = advertisement_fixture()
      assert {:ok, %Advertisement{}} = Marketplace.delete_advertisement(advertisement)
      assert_raise Ecto.NoResultsError, fn -> Marketplace.get_advertisement!(advertisement.id) end
    end

    test "change_advertisement/1 returns a advertisement changeset" do
      advertisement = advertisement_fixture()
      assert %Ecto.Changeset{} = Marketplace.change_advertisement(advertisement)
    end
  end
end
