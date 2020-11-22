defmodule AtmanirbharWeb.BulkUploadLive.FormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.BulkUpload

  def mount(socket) do
    {:ok, allow_upload(socket, :csv, accept: ~w(.csv), max_entries: 2 )}
  end

  @impl true
  def update(%{bulk_upload: bulk_upload} = assigns, socket) do
    changeset = Marketplace.change_bulk_upload(bulk_upload)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bulk_upload" => bulk_upload_params}, socket) do
    changeset =
      socket.assigns.bulk_upload
      |> Marketplace.change_bulk_upload(bulk_upload_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("cancel-entry", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :csv, ref)}
  end

  def handle_event("save", %{"bulk_upload" => bulk_upload_params}, socket) do
    save_bulk_upload(socket, socket.assigns.action, bulk_upload_params)
  end
  def handle_event("save_bulk_upload", %{"bulk_upload" => bulk_upload_params}, socket) do
    save_bulk_upload(socket, socket.assigns.action, bulk_upload_params)
  end

  defp save_bulk_upload(socket, :edit, bulk_upload_params) do
    bulk_upload = put_csv_urls(socket, socket.assigns.bulk_upload)
    case Marketplace.update_bulk_upload(bulk_upload, bulk_upload_params, &consume_csvs(socket, &1)) do
      {:ok, _bulk_upload} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bulk upload updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  # defp save_deal(socket, :new_deal, deal_params), do: save_deal(socket, :new, Map.put_new(deal_params, "is_approved", true) )
  defp save_bulk_upload(socket, :new_bulk_upload, bulk_upload_params), do: save_bulk_upload(socket, :new, bulk_upload_params)
  defp save_bulk_upload(socket, :new, bulk_upload_params) do
    bulk_upload = put_csv_urls(socket, socket.assigns.bulk_upload)
    case Marketplace.create_bulk_upload(bulk_upload, bulk_upload_params, &consume_csvs(socket, &1)) do
      {:ok, _bulk_upload} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bulk upload created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp ext(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
  end

  defp put_csv_urls(socket, %BulkUpload{} = bulk_upload) do
    {completed, []} = uploaded_entries(socket, :csv)
    urls = for entry <- completed do
      Routes.static_path(socket, "/uploads/#{entry.uuid}.#{ext(entry)}")
    end
    %BulkUpload{bulk_upload | csv_urls: urls}
  end

  def consume_csvs(socket, %BulkUpload{} = bulk_upload) do
    consume_uploaded_entries(socket, :csv, fn meta, entry ->
      dest = Routes.static_path(socket, "/uploads/#{entry.uuid}.#{ext(entry)}")
      # dest = Path.join("priv/static/uploads", "#{entry.uuid}.#{ext(entry)}")
      File.cp!(meta.path, dest)
    end)
    {:ok, bulk_upload}
  end

end
