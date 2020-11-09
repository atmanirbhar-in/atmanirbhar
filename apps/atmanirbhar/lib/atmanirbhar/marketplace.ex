defmodule Atmanirbhar.Marketplace do
  @moduledoc """
  The Marketplace context.
  """

  import Ecto.Query, warn: false
  alias Atmanirbhar.Repo

  alias Atmanirbhar.Marketplace.Shop
  alias Atmanirbhar.Marketplace.LocationForm

  @doc """
  Returns the list of shops.

  ## Examples

      iex> list_shops()
      [%Shop{}, ...]

  """
  def list_shops do
    Repo.all(Shop)
  end

  @doc """
  Gets a single shop.

  Raises `Ecto.NoResultsError` if the Shop does not exist.

  ## Examples

      iex> get_shop!(123)
      %Shop{}

      iex> get_shop!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shop!(id), do: Repo.get!(Shop, id)

  @doc """
  Creates a shop.

  ## Examples

      iex> create_shop(%{field: value})
      {:ok, %Shop{}}

      iex> create_shop(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shop(attrs \\ %{}) do
    %Shop{}
    |> Shop.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shop.

  ## Examples

      iex> update_shop(shop, %{field: new_value})
      {:ok, %Shop{}}

      iex> update_shop(shop, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shop(%Shop{} = shop, attrs) do
    shop
    |> Shop.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shop.

  ## Examples

      iex> delete_shop(shop)
      {:ok, %Shop{}}

      iex> delete_shop(shop)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shop(%Shop{} = shop) do
    Repo.delete(shop)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shop changes.

  ## Examples

      iex> change_shop(shop)
      %Ecto.Changeset{data: %Shop{}}

  """
  def change_shop(%Shop{} = shop, attrs \\ %{}) do
    Shop.changeset(shop, attrs)
  end

  def change_location_form(%LocationForm{} = location_form, attrs \\ %{}) do
    LocationForm.changeset(location_form, attrs)
  end

  alias Atmanirbhar.Marketplace.Advertisement

  @doc """
  Returns the list of advertisements.

  ## Examples

      iex> list_advertisements()
      [%Advertisement{}, ...]

  """
  def list_advertisements do
    Repo.all(Advertisement)
  end

  @doc """
  Gets a single advertisement.

  Raises `Ecto.NoResultsError` if the Advertisement does not exist.

  ## Examples

      iex> get_advertisement!(123)
      %Advertisement{}

      iex> get_advertisement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_advertisement!(id), do: Repo.get!(Advertisement, id)

  @doc """
  Creates a advertisement.

  ## Examples

      iex> create_advertisement(%{field: value})
      {:ok, %Advertisement{}}

      iex> create_advertisement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_advertisement(attrs \\ %{}) do
    %Advertisement{}
    |> Advertisement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a advertisement.

  ## Examples

      iex> update_advertisement(advertisement, %{field: new_value})
      {:ok, %Advertisement{}}

      iex> update_advertisement(advertisement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_advertisement(%Advertisement{} = advertisement, attrs) do
    advertisement
    |> Advertisement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a advertisement.

  ## Examples

      iex> delete_advertisement(advertisement)
      {:ok, %Advertisement{}}

      iex> delete_advertisement(advertisement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_advertisement(%Advertisement{} = advertisement) do
    Repo.delete(advertisement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking advertisement changes.

  ## Examples

      iex> change_advertisement(advertisement)
      %Ecto.Changeset{data: %Advertisement{}}

  """

  def change_advertisement(%Advertisement{} = advertisement, attrs \\ %{}) do
    Advertisement.changeset(advertisement, attrs)
  end

  alias Atmanirbhar.Marketplace.Deal

  @doc """
  Returns the list of deals.

  ## Examples

      iex> list_deals()
      [%Deal{}, ...]

  """
  def list_deals do
    Repo.all(from d in Deal, order_by: [desc: d.inserted_at])
  end
  def list_deals_for_pincode(pincode) do
    Repo.all(from d in Deal,
      where: d.pincode == ^pincode,
      order_by: [desc: d.inserted_at])
  end

  @doc """
  Gets a single deal.

  Raises `Ecto.NoResultsError` if the Deal does not exist.

  ## Examples

      iex> get_deal!(123)
      %Deal{}

      iex> get_deal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deal!(id), do: Repo.get!(Deal, id)

  @doc """
  Creates a deal.

  ## Examples

      iex> create_deal(%{field: value})
      {:ok, %Deal{}}

      iex> create_deal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deal(attrs \\ %{}) do
    %Deal{}
    |> Deal.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:deal_created)
  end

  @doc """
  Updates a deal.

  ## Examples

      iex> update_deal(deal, %{field: new_value})
      {:ok, %Deal{}}

      iex> update_deal(deal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deal(%Deal{} = deal, attrs) do
    deal
    |> Deal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deal.

  ## Examples

      iex> delete_deal(deal)
      {:ok, %Deal{}}

      iex> delete_deal(deal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deal(%Deal{} = deal) do
    Repo.delete(deal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deal changes.

  ## Examples

      iex> change_deal(deal)
      %Ecto.Changeset{data: %Deal{}}

  """
  def change_deal(%Deal{} = deal, attrs \\ %{}) do
    Deal.changeset(deal, attrs)
  end

  def subscribe(pincode) do
    Phoenix.PubSub.subscribe(Atmanirbhar.PubSub, "marketplace:#{pincode}")
  end
  def subscribe() do
    Phoenix.PubSub.subscribe(Atmanirbhar.PubSub, "marketplace")
  end

  defp broadcast({:error, reason} = error, _pincode, _event), do: error
  defp broadcast({:ok, deal = %Deal{}}, event) do
    Phoenix.PubSub.broadcast(Atmanirbhar.PubSub, "marketplace:#{deal.pincode}", {event, deal})
    {:ok, deal}
  end



  alias Atmanirbhar.Marketplace.Business

  @doc """
  Returns the list of businesses.

  ## Examples

      iex> list_businesses()
      [%Business{}, ...]

  """
  def list_businesses do
    Repo.all(Business)
  end

  @doc """
  Gets a single business.

  Raises `Ecto.NoResultsError` if the Business does not exist.

  ## Examples

      iex> get_business!(123)
      %Business{}

      iex> get_business!(456)
      ** (Ecto.NoResultsError)

  """
  def get_business!(id), do: Repo.get!(Business, id)

  @doc """
  Creates a business.

  ## Examples

      iex> create_business(%{field: value})
      {:ok, %Business{}}

      iex> create_business(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_business(attrs \\ %{}) do
    %Business{}
    |> Business.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a business.

  ## Examples

      iex> update_business(business, %{field: new_value})
      {:ok, %Business{}}

      iex> update_business(business, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_business(%Business{} = business, attrs) do
    business
    |> Business.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a business.

  ## Examples

      iex> delete_business(business)
      {:ok, %Business{}}

      iex> delete_business(business)
      {:error, %Ecto.Changeset{}}

  """
  def delete_business(%Business{} = business) do
    Repo.delete(business)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking business changes.

  ## Examples

      iex> change_business(business)
      %Ecto.Changeset{data: %Business{}}

  """
  def change_business(%Business{} = business, attrs \\ %{}) do
    Business.changeset(business, attrs)
  end

  alias Atmanirbhar.Marketplace.Product

  @doc """
  Returns the list of marketplace_products.

  ## Examples

      iex> list_marketplace_products()
      [%Product{}, ...]

  """
  def list_marketplace_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  alias Atmanirbhar.Marketplace.Deals

  @doc """
  Returns the list of marketplace_products_deals.

  ## Examples

      iex> list_marketplace_products_deals()
      [%Deals{}, ...]

  """
  def list_marketplace_products_deals do
    Repo.all(Deals)
  end

  @doc """
  Gets a single deals.

  Raises `Ecto.NoResultsError` if the Deals does not exist.

  ## Examples

      iex> get_deals!(123)
      %Deals{}

      iex> get_deals!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deals!(id), do: Repo.get!(Deals, id)

  @doc """
  Creates a deals.

  ## Examples

      iex> create_deals(%{field: value})
      {:ok, %Deals{}}

      iex> create_deals(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deals(attrs \\ %{}) do
    %Deals{}
    |> Deals.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deals.

  ## Examples

      iex> update_deals(deals, %{field: new_value})
      {:ok, %Deals{}}

      iex> update_deals(deals, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deals(%Deals{} = deals, attrs) do
    deals
    |> Deals.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deals.

  ## Examples

      iex> delete_deals(deals)
      {:ok, %Deals{}}

      iex> delete_deals(deals)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deals(%Deals{} = deals) do
    Repo.delete(deals)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deals changes.

  ## Examples

      iex> change_deals(deals)
      %Ecto.Changeset{data: %Deals{}}

  """
  def change_deals(%Deals{} = deals, attrs \\ %{}) do
    Deals.changeset(deals, attrs)
  end
end
