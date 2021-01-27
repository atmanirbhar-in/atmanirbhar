defmodule Atmanirbhar.Marketplace do
  @moduledoc """
  The Marketplace context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset, warn: false
  alias Atmanirbhar.Repo

  alias Atmanirbhar.Accounts.{User, UserToken}
  alias Atmanirbhar.Marketplace.{Business, GalleryUpload,
                                 Stall, GalleryItem,
                                 Media,
                                 LocationForm, StallFilters, BulkUpload}
  alias Atmanirbhar.Catalog.Product
  alias Atmanirbhar.Geo.Location

  def get_business!(id), do: Repo.get!(Business, id)

  def load_business_with_media!(business_id) do
    query = from business in Business,
      where: business.id == ^business_id,
      preload: [medias: :medias]
    query
    |> Repo.one
  end

  def change_business(%Business{} = business, attrs \\ %{}) do
    Business.changeset(business, attrs)
  end

  def create_user_business(%User{} = user, business_params) do
    Ecto.build_assoc(user, :business, business_params)
  end

  def list_user_businesses(input_token) do
    query = from stall in Stall,
      join: business in Business,
      on: stall.business_id == business.id,
      join: user in User,
      on: business.owner_id == user.id,
      join: user_token in UserToken,
      where: user_token.token == ^input_token,
      preload: [business: business],
      select: struct(stall, [:id, :title, :description, :location_id, :business_id,
                             location: [:id, :title],
                             business: [:id, :title, :description, :owner_id]])
    Repo.all(query)
  end

  def list_user_businesses2(%User{id: user_id} = input_user) do
    query = from business in Business,
      join: user in assoc(business, :user),
      preload: [:stalls],
      where: user.id == ^user_id

      query
      |> Repo.all
  end

  def list_stalls_for_business(input_business_id) do
    query = from stall in Stall,
      left_join: location in Location,
      on: stall.location_id == location.id,
      join: business in Business,
      on: stall.business_id == ^input_business_id,
      preload: [business: business, location: location],
      select: struct(stall, [:id, :title, :description, :location_id, :business_id, location: [:id, :title]])
    Repo.all(query)
  end

  def list_stalls_with_filters(%StallFilters{} = stall_filters) do
    StallFilters.query_for(stall_filters)
    |> Repo.all
    # |> Repo.preload(:gallery_items)
    # |> Repo.all
  end

  def create_media(business_id, gallery_params, after_save \\ &{:ok, &1}) do
    list_of_assocs = for photo_url <- gallery_params.urls do
      now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

      %{ business_id: business_id,
         url: photo_url,
         caption: gallery_params.title,
         inserted_at: now,
         updated_at: now
      }
    end
    Repo.insert_all(Media, list_of_assocs)
    |> after_save_bulk_photos(gallery_params.urls, after_save)
  end

  defp after_save_bulk_photos(_, picture_urls, func) do
    {:ok, _post} = func.(picture_urls)
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


  # # set GalleryItem type for Product
  # def create_product(attrs \\ %{}) do
  #   %GalleryItem{}
  #   |> GalleryItem.product_changeset(attrs)
  #   |> put_change(:type, 1)
  #   |> Repo.insert()
  # end

  # link gallery_item and stall
  # def add_gallery_item_to_stall(gallery_item = %GalleryItem{}, stall = %Stall{}) do
  # def add_gallery_item_to_stall(gallery_item_id, stall_id) do
  def add_gallery_item_to_stall(gallery_item_id, stall) do
    gallery_item = Repo.get!(GalleryItem, gallery_item_id)
    gallery_items = stall.gallery_items ++ [gallery_item]
    |> Enum.map(&Ecto.Changeset.change/1)

    stall
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:gallery_items, gallery_items)
    |> Repo.update
  end

  def remove_gallery_item_from_stall(gallery_item_id, stall) do
    gallery_item = Repo.get!(GalleryItem, gallery_item_id)
    gallery_items = stall.gallery_items -- [gallery_item]
    |> Enum.map(&Ecto.Changeset.change/1)

    stall
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:gallery_items, gallery_items)
    |> Repo.update
  end

  # set GalleryItem type for Happy Customers i.e Timeline post
  def create_timeline_post(attrs \\ %{}) do
    %GalleryItem{}
    |> GalleryItem.product_changeset(attrs)
    |> put_change(:type, 2)
    |> Repo.insert()
  end

  def list_products_of_business() do
    query = from se in GalleryItem,
      where: se.type == 1
    Repo.all query
  end

  def get_business_with_products(business_id) do
    # query = from business in Business,
    #   join: product in Product, assoc(product, :business),
    #   where: business.id == ^business_id,
    #   preload: [:business],
    #   select: [product: [:title, :description, :id, :business_id]]

    query = from business in Business,
      where: business.id == ^business_id,
      preload: [:products]

    query
    |> Repo.one
  end

  # TODO stall elements of User
  def list_all_gallery_items_of_business() do
    query = from se in GalleryItem
    Repo.all query
  end


  def list_business_media(business_id) do
    query = from media in Media,
      join: business in Business,
      on: business.id == media.business_id,
      where: business.id == ^business_id
    Repo.all query
  end


  # def add_gallery_items_to_stall do
  #   s2 = Atmanirbhar.Marketplace.get_stall!(2) |> Atmanirbhar.Repo.preload(:gallery_items)
  #   # cs = Ecto.Changeset.change(s2) |> Ecto.Changeset.put_assoc(:gallery_items, [se3])
  # end

  def get_gallery_item!(id), do: Repo.get!(GalleryItem, id)

  def change_product(%GalleryItem{} = product, attrs \\ %{}) do
    GalleryItem.product_changeset(product, attrs)
  end
  def change_timeline_post(%GalleryItem{} = product, attrs \\ %{}) do
    GalleryItem.timeline_post_changeset(product, attrs)
  end

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

  def change_gallery_upload(%GalleryUpload{} = gallery_upload, attrs \\ %{}) do
    GalleryUpload.changeset(gallery_upload, attrs)
  end

  def list_marketplace_stalls do
    Repo.all(Stall)
  end

  # def foo_bar_query(input_token) do
  #   from token in UserToken.token_and_context_query(input_token, "session"),
  #     join: user in assoc(token, :user),
  #     join: user_gallery in assoc(user, :user_gallery),
  #     on: user_gallery.user_id == user.id,
  #     join: gallery_items in assoc(user_gallery, :gallery_items),
  #     on: gallery_item.gallery_id == user_gallery.id,
  #     select: gallery_items
  #     # where: token == ^input_token
  # end

  # TODO token type has to be session
  def list_user_gallery_items(input_token) do
    query = from gallery_item in GalleryItem,
      join: user_gallery in assoc(gallery_item, :gallery),
      join: user in assoc(user_gallery, :user),
      on: user_gallery.user_id == user.id,
      join: user_token in UserToken,
      where: user_token.token == ^input_token,
      preload: [:user, :user_gallery],
      select: gallery_item

    query
    |> Repo.all()
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
    Repo.one(query) |> Repo.preload(:gallery_items)
  end

  def create_stall(attrs \\ %{}) do
    %Stall{}
    |> Stall.create_changeset(attrs)
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
