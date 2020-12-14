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

  describe "deals" do
    alias Atmanirbhar.Marketplace.Deal

    @valid_attrs %{availability: "some availability", description: "some description", is_approved: true, name: "some name", name_hindi: "some name_hindi", price: 42}
    @update_attrs %{availability: "some updated availability", description: "some updated description", is_approved: false, name: "some updated name", name_hindi: "some updated name_hindi", price: 43}
    @invalid_attrs %{availability: nil, description: nil, is_approved: nil, name: nil, name_hindi: nil, price: nil}

    def deal_fixture(attrs \\ %{}) do
      {:ok, deal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marketplace.create_deal()

      deal
    end

    test "list_deals/0 returns all deals" do
      deal = deal_fixture()
      assert Marketplace.list_deals() == [deal]
    end

    test "get_deal!/1 returns the deal with given id" do
      deal = deal_fixture()
      assert Marketplace.get_deal!(deal.id) == deal
    end

    test "create_deal/1 with valid data creates a deal" do
      assert {:ok, %Deal{} = deal} = Marketplace.create_deal(@valid_attrs)
      assert deal.availability == "some availability"
      assert deal.description == "some description"
      assert deal.is_approved == true
      assert deal.name == "some name"
      assert deal.name_hindi == "some name_hindi"
      assert deal.price == 42
    end

    test "create_deal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marketplace.create_deal(@invalid_attrs)
    end

    test "update_deal/2 with valid data updates the deal" do
      deal = deal_fixture()
      assert {:ok, %Deal{} = deal} = Marketplace.update_deal(deal, @update_attrs)
      assert deal.availability == "some updated availability"
      assert deal.description == "some updated description"
      assert deal.is_approved == false
      assert deal.name == "some updated name"
      assert deal.name_hindi == "some updated name_hindi"
      assert deal.price == 43
    end

    test "update_deal/2 with invalid data returns error changeset" do
      deal = deal_fixture()
      assert {:error, %Ecto.Changeset{}} = Marketplace.update_deal(deal, @invalid_attrs)
      assert deal == Marketplace.get_deal!(deal.id)
    end

    test "delete_deal/1 deletes the deal" do
      deal = deal_fixture()
      assert {:ok, %Deal{}} = Marketplace.delete_deal(deal)
      assert_raise Ecto.NoResultsError, fn -> Marketplace.get_deal!(deal.id) end
    end

    test "change_deal/1 returns a deal changeset" do
      deal = deal_fixture()
      assert %Ecto.Changeset{} = Marketplace.change_deal(deal)
    end
  end

  describe "businesses" do
    alias Atmanirbhar.Marketplace.Business

    @valid_attrs %{address: "some address", description: "some description", power_index: 42, title: "some title"}
    @update_attrs %{address: "some updated address", description: "some updated description", power_index: 43, title: "some updated title"}
    @invalid_attrs %{address: nil, description: nil, power_index: nil, title: nil}

    def business_fixture(attrs \\ %{}) do
      {:ok, business} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marketplace.create_business()

      business
    end

    test "list_businesses/0 returns all businesses" do
      business = business_fixture()
      assert Marketplace.list_businesses() == [business]
    end

    test "get_business!/1 returns the business with given id" do
      business = business_fixture()
      assert Marketplace.get_business!(business.id) == business
    end

    test "create_business/1 with valid data creates a business" do
      assert {:ok, %Business{} = business} = Marketplace.create_business(@valid_attrs)
      assert business.address == "some address"
      assert business.description == "some description"
      assert business.power_index == 42
      assert business.title == "some title"
    end

    test "create_business/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marketplace.create_business(@invalid_attrs)
    end

    test "update_business/2 with valid data updates the business" do
      business = business_fixture()
      assert {:ok, %Business{} = business} = Marketplace.update_business(business, @update_attrs)
      assert business.address == "some updated address"
      assert business.description == "some updated description"
      assert business.power_index == 43
      assert business.title == "some updated title"
    end

    test "update_business/2 with invalid data returns error changeset" do
      business = business_fixture()
      assert {:error, %Ecto.Changeset{}} = Marketplace.update_business(business, @invalid_attrs)
      assert business == Marketplace.get_business!(business.id)
    end

    test "delete_business/1 deletes the business" do
      business = business_fixture()
      assert {:ok, %Business{}} = Marketplace.delete_business(business)
      assert_raise Ecto.NoResultsError, fn -> Marketplace.get_business!(business.id) end
    end

    test "change_business/1 returns a business changeset" do
      business = business_fixture()
      assert %Ecto.Changeset{} = Marketplace.change_business(business)
    end
  end

  describe "marketplace_products" do
    alias Atmanirbhar.Marketplace.Product

    @valid_attrs %{delivery_details: "some delivery_details", description: "some description", price: 42}
    @update_attrs %{delivery_details: "some updated delivery_details", description: "some updated description", price: 43}
    @invalid_attrs %{delivery_details: nil, description: nil, price: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marketplace.create_product()

      product
    end

    test "list_marketplace_products/0 returns all marketplace_products" do
      product = product_fixture()
      assert Marketplace.list_marketplace_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Marketplace.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Marketplace.create_product(@valid_attrs)
      assert product.delivery_details == "some delivery_details"
      assert product.description == "some description"
      assert product.price == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marketplace.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Marketplace.update_product(product, @update_attrs)
      assert product.delivery_details == "some updated delivery_details"
      assert product.description == "some updated description"
      assert product.price == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Marketplace.update_product(product, @invalid_attrs)
      assert product == Marketplace.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Marketplace.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Marketplace.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Marketplace.change_product(product)
    end
  end

  describe "marketplace_products_deals" do
    alias Atmanirbhar.Marketplace.Deals

    @valid_attrs %{date: ~D[2010-04-17], price: 42, status: 42}
    @update_attrs %{date: ~D[2011-05-18], price: 43, status: 43}
    @invalid_attrs %{date: nil, price: nil, status: nil}

    def deals_fixture(attrs \\ %{}) do
      {:ok, deals} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marketplace.create_deals()

      deals
    end

    test "list_marketplace_products_deals/0 returns all marketplace_products_deals" do
      deals = deals_fixture()
      assert Marketplace.list_marketplace_products_deals() == [deals]
    end

    test "get_deals!/1 returns the deals with given id" do
      deals = deals_fixture()
      assert Marketplace.get_deals!(deals.id) == deals
    end

    test "create_deals/1 with valid data creates a deals" do
      assert {:ok, %Deals{} = deals} = Marketplace.create_deals(@valid_attrs)
      assert deals.date == ~D[2010-04-17]
      assert deals.price == 42
      assert deals.status == 42
    end

    test "create_deals/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marketplace.create_deals(@invalid_attrs)
    end

    test "update_deals/2 with valid data updates the deals" do
      deals = deals_fixture()
      assert {:ok, %Deals{} = deals} = Marketplace.update_deals(deals, @update_attrs)
      assert deals.date == ~D[2011-05-18]
      assert deals.price == 43
      assert deals.status == 43
    end

    test "update_deals/2 with invalid data returns error changeset" do
      deals = deals_fixture()
      assert {:error, %Ecto.Changeset{}} = Marketplace.update_deals(deals, @invalid_attrs)
      assert deals == Marketplace.get_deals!(deals.id)
    end

    test "delete_deals/1 deletes the deals" do
      deals = deals_fixture()
      assert {:ok, %Deals{}} = Marketplace.delete_deals(deals)
      assert_raise Ecto.NoResultsError, fn -> Marketplace.get_deals!(deals.id) end
    end

    test "change_deals/1 returns a deals changeset" do
      deals = deals_fixture()
      assert %Ecto.Changeset{} = Marketplace.change_deals(deals)
    end
  end

  describe "marketplace_bulk_uploads" do
    alias Atmanirbhar.Marketplace.BulkUpload

    @valid_attrs %{city_name: "some city_name", content_description: "some content_description", file_url: "some file_url", location_name: "some location_name", processesed_flag: true}
    @update_attrs %{city_name: "some updated city_name", content_description: "some updated content_description", file_url: "some updated file_url", location_name: "some updated location_name", processesed_flag: false}
    @invalid_attrs %{city_name: nil, content_description: nil, file_url: nil, location_name: nil, processesed_flag: nil}

    def bulk_upload_fixture(attrs \\ %{}) do
      {:ok, bulk_upload} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marketplace.create_bulk_upload()

      bulk_upload
    end

    test "list_marketplace_bulk_uploads/0 returns all marketplace_bulk_uploads" do
      bulk_upload = bulk_upload_fixture()
      assert Marketplace.list_marketplace_bulk_uploads() == [bulk_upload]
    end

    test "get_bulk_upload!/1 returns the bulk_upload with given id" do
      bulk_upload = bulk_upload_fixture()
      assert Marketplace.get_bulk_upload!(bulk_upload.id) == bulk_upload
    end

    test "create_bulk_upload/1 with valid data creates a bulk_upload" do
      assert {:ok, %BulkUpload{} = bulk_upload} = Marketplace.create_bulk_upload(@valid_attrs)
      assert bulk_upload.city_name == "some city_name"
      assert bulk_upload.content_description == "some content_description"
      assert bulk_upload.file_url == "some file_url"
      assert bulk_upload.location_name == "some location_name"
      assert bulk_upload.processesed_flag == true
    end

    test "create_bulk_upload/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marketplace.create_bulk_upload(@invalid_attrs)
    end

    test "update_bulk_upload/2 with valid data updates the bulk_upload" do
      bulk_upload = bulk_upload_fixture()
      assert {:ok, %BulkUpload{} = bulk_upload} = Marketplace.update_bulk_upload(bulk_upload, @update_attrs)
      assert bulk_upload.city_name == "some updated city_name"
      assert bulk_upload.content_description == "some updated content_description"
      assert bulk_upload.file_url == "some updated file_url"
      assert bulk_upload.location_name == "some updated location_name"
      assert bulk_upload.processesed_flag == false
    end

    test "update_bulk_upload/2 with invalid data returns error changeset" do
      bulk_upload = bulk_upload_fixture()
      assert {:error, %Ecto.Changeset{}} = Marketplace.update_bulk_upload(bulk_upload, @invalid_attrs)
      assert bulk_upload == Marketplace.get_bulk_upload!(bulk_upload.id)
    end

    test "delete_bulk_upload/1 deletes the bulk_upload" do
      bulk_upload = bulk_upload_fixture()
      assert {:ok, %BulkUpload{}} = Marketplace.delete_bulk_upload(bulk_upload)
      assert_raise Ecto.NoResultsError, fn -> Marketplace.get_bulk_upload!(bulk_upload.id) end
    end

    test "change_bulk_upload/1 returns a bulk_upload changeset" do
      bulk_upload = bulk_upload_fixture()
      assert %Ecto.Changeset{} = Marketplace.change_bulk_upload(bulk_upload)
    end
  end

  describe "marketplace_stalls" do
    alias Atmanirbhar.Marketplace.Stall

    @valid_attrs %{audience_average: 42, description: "some description", for_female: true, for_male: true, is_active: true, poster_image_url: "some poster_image_url", title: "some title"}
    @update_attrs %{audience_average: 43, description: "some updated description", for_female: false, for_male: false, is_active: false, poster_image_url: "some updated poster_image_url", title: "some updated title"}
    @invalid_attrs %{audience_average: nil, description: nil, for_female: nil, for_male: nil, is_active: nil, poster_image_url: nil, title: nil}

    def stall_fixture(attrs \\ %{}) do
      {:ok, stall} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marketplace.create_stall()

      stall
    end

    test "list_marketplace_stalls/0 returns all marketplace_stalls" do
      stall = stall_fixture()
      assert Marketplace.list_marketplace_stalls() == [stall]
    end

    test "get_stall!/1 returns the stall with given id" do
      stall = stall_fixture()
      assert Marketplace.get_stall!(stall.id) == stall
    end

    test "create_stall/1 with valid data creates a stall" do
      assert {:ok, %Stall{} = stall} = Marketplace.create_stall(@valid_attrs)
      assert stall.audience_average == 42
      assert stall.description == "some description"
      assert stall.for_female == true
      assert stall.for_male == true
      assert stall.is_active == true
      assert stall.poster_image_url == "some poster_image_url"
      assert stall.title == "some title"
    end

    test "create_stall/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marketplace.create_stall(@invalid_attrs)
    end

    test "update_stall/2 with valid data updates the stall" do
      stall = stall_fixture()
      assert {:ok, %Stall{} = stall} = Marketplace.update_stall(stall, @update_attrs)
      assert stall.audience_average == 43
      assert stall.description == "some updated description"
      assert stall.for_female == false
      assert stall.for_male == false
      assert stall.is_active == false
      assert stall.poster_image_url == "some updated poster_image_url"
      assert stall.title == "some updated title"
    end

    test "update_stall/2 with invalid data returns error changeset" do
      stall = stall_fixture()
      assert {:error, %Ecto.Changeset{}} = Marketplace.update_stall(stall, @invalid_attrs)
      assert stall == Marketplace.get_stall!(stall.id)
    end

    test "delete_stall/1 deletes the stall" do
      stall = stall_fixture()
      assert {:ok, %Stall{}} = Marketplace.delete_stall(stall)
      assert_raise Ecto.NoResultsError, fn -> Marketplace.get_stall!(stall.id) end
    end

    test "change_stall/1 returns a stall changeset" do
      stall = stall_fixture()
      assert %Ecto.Changeset{} = Marketplace.change_stall(stall)
    end
  end
end
