defmodule Atmanirbhar.GeoTest do
  use Atmanirbhar.DataCase

  alias Atmanirbhar.Geo

  describe "pincodes" do
    alias Atmanirbhar.Geo.Pincode

    @valid_attrs %{city: "some city", description: "some description", name: 42}
    @update_attrs %{city: "some updated city", description: "some updated description", name: 43}
    @invalid_attrs %{city: nil, description: nil, name: nil}

    def pincode_fixture(attrs \\ %{}) do
      {:ok, pincode} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Geo.create_pincode()

      pincode
    end

    test "list_pincodes/0 returns all pincodes" do
      pincode = pincode_fixture()
      assert Geo.list_pincodes() == [pincode]
    end

    test "get_pincode!/1 returns the pincode with given id" do
      pincode = pincode_fixture()
      assert Geo.get_pincode!(pincode.id) == pincode
    end

    test "create_pincode/1 with valid data creates a pincode" do
      assert {:ok, %Pincode{} = pincode} = Geo.create_pincode(@valid_attrs)
      assert pincode.city == "some city"
      assert pincode.description == "some description"
      assert pincode.name == 42
    end

    test "create_pincode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_pincode(@invalid_attrs)
    end

    test "update_pincode/2 with valid data updates the pincode" do
      pincode = pincode_fixture()
      assert {:ok, %Pincode{} = pincode} = Geo.update_pincode(pincode, @update_attrs)
      assert pincode.city == "some updated city"
      assert pincode.description == "some updated description"
      assert pincode.name == 43
    end

    test "update_pincode/2 with invalid data returns error changeset" do
      pincode = pincode_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_pincode(pincode, @invalid_attrs)
      assert pincode == Geo.get_pincode!(pincode.id)
    end

    test "delete_pincode/1 deletes the pincode" do
      pincode = pincode_fixture()
      assert {:ok, %Pincode{}} = Geo.delete_pincode(pincode)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_pincode!(pincode.id) end
    end

    test "change_pincode/1 returns a pincode changeset" do
      pincode = pincode_fixture()
      assert %Ecto.Changeset{} = Geo.change_pincode(pincode)
    end
  end

  describe "cities" do
    alias Atmanirbhar.Geo.City

    @valid_attrs %{description: "some description", name: "some name", name_hinndi: "some name_hinndi"}
    @update_attrs %{description: "some updated description", name: "some updated name", name_hinndi: "some updated name_hinndi"}
    @invalid_attrs %{description: nil, name: nil, name_hinndi: nil}

    def city_fixture(attrs \\ %{}) do
      {:ok, city} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Geo.create_city()

      city
    end

    test "list_cities/0 returns all cities" do
      city = city_fixture()
      assert Geo.list_cities() == [city]
    end

    test "get_city!/1 returns the city with given id" do
      city = city_fixture()
      assert Geo.get_city!(city.id) == city
    end

    test "create_city/1 with valid data creates a city" do
      assert {:ok, %City{} = city} = Geo.create_city(@valid_attrs)
      assert city.description == "some description"
      assert city.name == "some name"
      assert city.name_hinndi == "some name_hinndi"
    end

    test "create_city/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_city(@invalid_attrs)
    end

    test "update_city/2 with valid data updates the city" do
      city = city_fixture()
      assert {:ok, %City{} = city} = Geo.update_city(city, @update_attrs)
      assert city.description == "some updated description"
      assert city.name == "some updated name"
      assert city.name_hinndi == "some updated name_hinndi"
    end

    test "update_city/2 with invalid data returns error changeset" do
      city = city_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_city(city, @invalid_attrs)
      assert city == Geo.get_city!(city.id)
    end

    test "delete_city/1 deletes the city" do
      city = city_fixture()
      assert {:ok, %City{}} = Geo.delete_city(city)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_city!(city.id) end
    end

    test "change_city/1 returns a city changeset" do
      city = city_fixture()
      assert %Ecto.Changeset{} = Geo.change_city(city)
    end
  end

  describe "locations" do
    alias Atmanirbhar.Geo.Location

    @valid_attrs %{match_slugs: [], nearby_slugs: [], slug: "some slug", title: "some title"}
    @update_attrs %{match_slugs: [], nearby_slugs: [], slug: "some updated slug", title: "some updated title"}
    @invalid_attrs %{match_slugs: nil, nearby_slugs: nil, slug: nil, title: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Geo.create_location()

      location
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Geo.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Geo.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Geo.create_location(@valid_attrs)
      assert location.match_slugs == []
      assert location.nearby_slugs == []
      assert location.slug == "some slug"
      assert location.title == "some title"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, %Location{} = location} = Geo.update_location(location, @update_attrs)
      assert location.match_slugs == []
      assert location.nearby_slugs == []
      assert location.slug == "some updated slug"
      assert location.title == "some updated title"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_location(location, @invalid_attrs)
      assert location == Geo.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Geo.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Geo.change_location(location)
    end
  end
end
