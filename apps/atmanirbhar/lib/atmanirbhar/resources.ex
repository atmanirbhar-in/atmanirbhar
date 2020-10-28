defmodule Atmanirbhar.Resources do
  @moduledoc """
  The Resources context.
  """

  import Ecto.Query, warn: false
  alias Atmanirbhar.Repo

  alias Atmanirbhar.Resources.RawMaterial

  @doc """
  Returns the list of raw_materials.

  ## Examples

      iex> list_raw_materials()
      [%RawMaterial{}, ...]

  """
  def list_raw_materials do
    Repo.all(RawMaterial)
  end

  @doc """
  Gets a single raw_material.

  Raises `Ecto.NoResultsError` if the Raw material does not exist.

  ## Examples

      iex> get_raw_material!(123)
      %RawMaterial{}

      iex> get_raw_material!(456)
      ** (Ecto.NoResultsError)

  """
  def get_raw_material!(id), do: Repo.get!(RawMaterial, id)

  @doc """
  Creates a raw_material.

  ## Examples

      iex> create_raw_material(%{field: value})
      {:ok, %RawMaterial{}}

      iex> create_raw_material(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_raw_material(attrs \\ %{}) do
    %RawMaterial{}
    |> RawMaterial.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a raw_material.

  ## Examples

      iex> update_raw_material(raw_material, %{field: new_value})
      {:ok, %RawMaterial{}}

      iex> update_raw_material(raw_material, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_raw_material(%RawMaterial{} = raw_material, attrs) do
    raw_material
    |> RawMaterial.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a raw_material.

  ## Examples

      iex> delete_raw_material(raw_material)
      {:ok, %RawMaterial{}}

      iex> delete_raw_material(raw_material)
      {:error, %Ecto.Changeset{}}

  """
  def delete_raw_material(%RawMaterial{} = raw_material) do
    Repo.delete(raw_material)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking raw_material changes.

  ## Examples

      iex> change_raw_material(raw_material)
      %Ecto.Changeset{data: %RawMaterial{}}

  """
  def change_raw_material(%RawMaterial{} = raw_material, attrs \\ %{}) do
    RawMaterial.changeset(raw_material, attrs)
  end
end
