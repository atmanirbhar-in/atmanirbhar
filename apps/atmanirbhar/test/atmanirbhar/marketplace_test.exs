defmodule Atmanirbhar.MarketplaceTest do
  use Atmanirbhar.DataCase

  alias Atmanirbhar.Marketplace

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
