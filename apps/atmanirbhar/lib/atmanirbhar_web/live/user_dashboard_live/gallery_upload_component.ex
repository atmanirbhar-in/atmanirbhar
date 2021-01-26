defmodule AtmanirbharWeb.UserDashboardLive.GalleryUploadComponent do
  use AtmanirbharWeb, :live_component
  alias Atmanirbhar.Marketplace

  # maybe here is problem?
  def mount(socket) do
    # user_token = session
    # |> Map.get("user_token")

    {:ok,
     # assign(socket, :user_token, user_token),
     allow_upload(socket, :picture, accept: [".png", ".jpg"], max_entries: 4)
    }
  end

  # socket, session, params?
  def update(%{gallery_upload: input_gallery_upload} = assigns, socket) do
    changeset = Atmanirbhar.Marketplace.change_gallery_upload(input_gallery_upload)
    {:ok, socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def handle_event("validate", %{"gallery_upload" => gallery_upload_params}, socket) do
    changeset =
      socket.assigns.gallery_upload
      |> Marketplace.change_gallery_upload(gallery_upload_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("cancel-entry", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :picture, ref)}
  end

  def handle_event("save",
    %{"gallery_upload" => gallery_params} = params, socket) do
    list_of_pictures = put_image_urls(socket)
    business = Marketplace.get_business!(socket.assigns.business_id)
    # Marketplace.create_media(socket.business_id, list_of_pictures)
    case Marketplace.create_media(business, gallery_params, &consume_pictures(socket, &1)) do
      {:ok, _bulk_upload} ->
        {:noreply,
         socket
         |> put_flash(:info, "Photos uploaded to Gallery successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp put_image_urls(socket) do
    {completed, [] } = uploaded_entries(socket, :picture)
    image_urls = for entry <- completed do
      Routes.static_path(socket, "/uploads/#{entry.uuid}.#{ext(entry)}")
    end
  end

  def consume_pictures(socket, business) do
    consume_uploaded_entries(socket, :picture, fn meta, entry ->
      dest = Path.join("priv/static/uploads", "#{entry.uuid}.#{ext(entry)}")
      File.cp!(meta.path, dest)
    end)
    {:ok, business}
  end

  defp ext(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
  end
end
