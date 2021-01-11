defmodule Atmanirbhar.Marketplace do
  @moduledoc """
  The Marketplace context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset, warn: false
  alias Atmanirbhar.Repo

  alias Atmanirbhar.Accounts.User
  alias Atmanirbhar.Marketplace.{Shop, Business, Stall, StallElement}
  alias Atmanirbhar.Geo.Location
  alias Atmanirbhar.Marketplace.{LocationForm, StallFilters}

  # with stalls?
  def list_user_businesses(user_id) do
    query = from business in Business,
      join: stalls in assoc(business, :stalls),
      join: location in assoc(stalls, :location),
      # on: stalls.location_id == location.id,
      # left_join: entity in assoc(s, :entity),
      # on: stall.business_id == business.id,
      where: business.owner_id == ^user_id,
      where: stalls.location_id == location.id,
      preload: [stalls: {stalls, location: location}],
      # preload: [entity: {entity, topics: topics, comments: comments}]
      # |> preload([user, posts, comments], [posts: {posts, comments: comments}])
      select: struct(business, [:id, :title, :owner_id, :description, :address, stalls: [:id, :business_id, :title, location: [:id, :title]]])
    Repo.all(query)
  end

  def list_stalls_for_business() do
    query = from stall in Stall,
      join: location in Location,
      join: business in Business,
      where: stall.location_id == location.id,
      where: stall.business_id == business.id,
      preload: [business: business, location: location],
      select: struct(stall, [:id, :title, :description, :location_id, :business_id, location: [:id, :title]])
    Repo.all(query)
  end

  def list_stalls_with_filters(%StallFilters{} = stall_filters) do
    StallFilters.query_for(stall_filters)
    |> Repo.all
    # |> Repo.preload(:stall_elements)
    # |> Repo.all
  end



  def change_location_form(%LocationForm{} = location_form, attrs \\ %{}) do
    LocationForm.changeset(location_form, attrs)
  end

  # default params when empty
  def change_stall_filters(%StallFilters{} = stall_filters, input_params \\ %{}) do

    raw_params = input_params
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})

    stall_filters_prepared = %{
      show_male: Map.get(raw_params, "show_male", true) |> to_bool,
      show_female: Map.get(raw_params, "show_female", true) |> to_bool,
      audience_min: Map.get(raw_params, "minimum_audience", "20") |> parse_num,
      audience_max: Map.get(raw_params, "maximum_audience", "60") |> parse_num,
      pincode: Map.get(raw_params, "pincode", "413512") |> parse_num,
    }

    StallFilters.changeset(stall_filters, stall_filters_prepared)
  end

  defp to_bool("true"), do: true
  defp to_bool("false"), do: false
  defp to_bool(_), do: true

  defp parse_num(string) do
    {number, _} = Integer.parse(string)
    number
  end

  # def subscribe(pincode) do
  #   Phoenix.PubSub.subscribe(Atmanirbhar.PubSub, "marketplace:#{pincode}")
  # end
  # def subscribe() do
  #   Phoenix.PubSub.subscribe(Atmanirbhar.PubSub, "marketplace")
  # end

  # defp broadcast({:error, reason} = error, _pincode, _event), do: error
  # defp broadcast({:ok, deal = %Deal{}}, event) do
  #   Phoenix.PubSub.broadcast(Atmanirbhar.PubSub, "marketplace:#{deal.pincode}", {event, deal})
  #   {:ok, deal}
  # end



  alias Atmanirbhar.Marketplace.Product


  # set StallElement type for Product
  def create_product(attrs \\ %{}) do
    %StallElement{}
    |> StallElement.product_changeset(attrs)
    |> put_change(:type, 1)
    |> Repo.insert()
  end

  # link stall_element and stall
  # def add_stall_element_to_stall(stall_element = %StallElement{}, stall = %Stall{}) do
  # def add_stall_element_to_stall(stall_element_id, stall_id) do
  def add_stall_element_to_stall(stall_element_id, stall) do
    stall_element = Repo.get!(StallElement, stall_element_id)
    stall_elements = stall.stall_elements ++ [stall_element]
    |> Enum.map(&Ecto.Changeset.change/1)

    stall
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:stall_elements, stall_elements)
    |> Repo.update
  end



  def remove_stall_element_from_stall(stall_element_id, stall) do

    stall_element = Repo.get!(StallElement, stall_element_id)
    stall_elements = stall.stall_elements -- [stall_element]
    |> Enum.map(&Ecto.Changeset.change/1)
    # |> Enum.map(&changeset(&1, %{"delete" => "true"}))

    stall
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:stall_elements, stall_elements)
    |> Repo.update
  end

  # set StallElement type for Happy Customers i.e Timeline post
  def create_timeline_post(attrs \\ %{}) do
    %StallElement{}
    |> StallElement.product_changeset(attrs)
    |> put_change(:type, 2)
    |> Repo.insert()
  end

  def list_products_of_business() do
    query = from se in StallElement,
      where: se.type == 1
    Repo.all query
  end

  def list_all_stall_elements_of_business() do
    query = from se in StallElement
    Repo.all query
  end

  def add_stall_elements_to_stall do
    s2 = Atmanirbhar.Marketplace.get_stall!(2) |> Atmanirbhar.Repo.preload(:stall_elements)
    # cs = Ecto.Changeset.change(s2) |> Ecto.Changeset.put_assoc(:stall_elements, [se3])
  end

  def get_stall_element!(id), do: Repo.get!(StallElement, id)
  # def update_product(%Product{} = product, attrs) do
  #   product
  #   |> Product.changeset(attrs)
  #   |> Repo.update()
  # end

  # def delete_product(%Product{} = product) do
  #   Repo.delete(product)
  # end

  def change_product(%StallElement{} = product, attrs \\ %{}) do
    StallElement.product_changeset(product, attrs)
  end
  def change_timeline_post(%StallElement{} = product, attrs \\ %{}) do
    StallElement.timeline_post_changeset(product, attrs)
  end

  alias Atmanirbhar.Marketplace.BulkUpload

  def list_marketplace_bulk_uploads do
    Repo.all(BulkUpload)
  end

  def get_bulk_upload!(id), do: Repo.get!(BulkUpload, id)

  def create_bulk_upload(bulk_upload, attrs \\ %{}, after_save \\ &{:ok, &1}) do
    bulk_upload
    |> BulkUpload.changeset(attrs)
    |> Repo.insert()
    |> after_save_bulk_upload(after_save)
  end

  defp after_save_bulk_upload({:ok, bulk_upload}, func) do
    {:ok, _post} = func.(bulk_upload)
  end
  defp after_save_bulk_upload(error, _func) do
    error
  end

  def update_bulk_upload(%BulkUpload{} = bulk_upload, attrs, after_save \\ &{:ok, &1}) do
    bulk_upload
    |> BulkUpload.changeset(attrs)
    |> Repo.update()
    |> after_save_bulk_upload(after_save)
  end

  def delete_bulk_upload(%BulkUpload{} = bulk_upload) do
    Repo.delete(bulk_upload)
  end

  def change_bulk_upload(%BulkUpload{} = bulk_upload, attrs \\ %{}) do
    BulkUpload.changeset(bulk_upload, attrs)
  end

  alias Atmanirbhar.Marketplace.Stall

  def list_marketplace_stalls do
    Repo.all(Stall)
  end

  def get_stall!(id), do: Repo.get!(Stall, id)

  def get_stall_detail!(id) do
    query = from stall in Stall,
      join: business in Business,
      join: location in Location,
      on: stall.business_id == business.id,
      on: stall.location_id == location.id,
      where: stall.id == ^id,
      preload: [business: business, location: location],
      select: struct(stall, [:id, :title, :description, :location_id, :business_id, business: [:id, :title, :address], location: [:id, :title]])
    Repo.one(query) |> Repo.preload(:stall_elements)
  end

  def create_stall(attrs \\ %{}) do
    %Stall{}
    |> Stall.changeset(attrs)
    |> Repo.insert()
  end

  def update_stall(%Stall{} = stall, attrs) do
    stall
    |> Stall.changeset(attrs)
    |> Repo.update()
  end

  def delete_stall(%Stall{} = stall) do
    Repo.delete(stall)
  end

  def change_stall(%Stall{} = stall, attrs \\ %{}) do
    Stall.changeset(stall, attrs)
  end
end
