defmodule Atmanirbhar.Geo do
  @moduledoc """
  The Geo context.
  """

  import Ecto.Query, warn: false
  alias Atmanirbhar.Repo

  alias Atmanirbhar.Geo.Pincode

  @doc """
  Returns the list of pincodes.

  ## Examples

      iex> list_pincodes()
      [%Pincode{}, ...]

  """
  def list_pincodes do
    Repo.all(Pincode)
  end

  def list_only_pincodes do
    Repo.all(from p in Pincode, select: p.name)
  end

  @doc """
  Gets a single pincode.

  Raises `Ecto.NoResultsError` if the Pincode does not exist.

  ## Examples

      iex> get_pincode!(123)
      %Pincode{}

      iex> get_pincode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pincode!(id), do: Repo.get!(Pincode, id)

  @doc """
  Creates a pincode.

  ## Examples

      iex> create_pincode(%{field: value})
      {:ok, %Pincode{}}

      iex> create_pincode(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pincode(attrs \\ %{}) do
    %Pincode{}
    |> Pincode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pincode.

  ## Examples

      iex> update_pincode(pincode, %{field: new_value})
      {:ok, %Pincode{}}

      iex> update_pincode(pincode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pincode(%Pincode{} = pincode, attrs) do
    pincode
    |> Pincode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pincode.

  ## Examples

      iex> delete_pincode(pincode)
      {:ok, %Pincode{}}

      iex> delete_pincode(pincode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pincode(%Pincode{} = pincode) do
    Repo.delete(pincode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pincode changes.

  ## Examples

      iex> change_pincode(pincode)
      %Ecto.Changeset{data: %Pincode{}}

  """
  def change_pincode(%Pincode{} = pincode, attrs \\ %{}) do
    Pincode.changeset(pincode, attrs)
  end

  alias Atmanirbhar.Geo.City

  @doc """
  Returns the list of cities.

  ## Examples

      iex> list_cities()
      [%City{}, ...]

  """
  def list_cities do
    Repo.all(City)
  end

  def list_only_cities do
    Repo.all(from c in City, select: {c.name, c.id})
  end

  @doc """
  Gets a single city.

  Raises `Ecto.NoResultsError` if the City does not exist.

  ## Examples

      iex> get_city!(123)
      %City{}

      iex> get_city!(456)
      ** (Ecto.NoResultsError)

  """
  def get_city!(id), do: Repo.get!(City, id)

  @doc """
  Creates a city.

  ## Examples

      iex> create_city(%{field: value})
      {:ok, %City{}}

      iex> create_city(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_city(attrs \\ %{}) do
    %City{}
    |> City.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a city.

  ## Examples

      iex> update_city(city, %{field: new_value})
      {:ok, %City{}}

      iex> update_city(city, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_city(%City{} = city, attrs) do
    city
    |> City.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a city.

  ## Examples

      iex> delete_city(city)
      {:ok, %City{}}

      iex> delete_city(city)
      {:error, %Ecto.Changeset{}}

  """
  def delete_city(%City{} = city) do
    Repo.delete(city)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking city changes.

  ## Examples

      iex> change_city(city)
      %Ecto.Changeset{data: %City{}}

  """
  def change_city(%City{} = city, attrs \\ %{}) do
    City.changeset(city, attrs)
  end

  alias Atmanirbhar.Geo.Location

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations do
    Repo.all(Location)
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{data: %Location{}}

  """
  def change_location(%Location{} = location, attrs \\ %{}) do
    Location.changeset(location, attrs)
  end
end
