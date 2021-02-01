defmodule AtmanirbharWeb.UserDashboardLive.ProductFormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Catalog
  alias Atmanirbhar.Catalog.Product

  def mount(socket) do

    if connected?(socket) do
      path = uploads_path()
      File.mkdir_p!(path)
    end

    {:ok,
     socket
     |> allow_upload(:product_image, accept: ~w(.jpg .png .jpeg), max_entries: 4)
    }
  end

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Catalog.change_product(product)
    {:ok,
     socket
     |> assign(assigns)
     # |> assign(:current_user, socket.assigns.current_user)
     # |> assign(:current_business, socket.assigns.current_business)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Catalog.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp save_product(socket, :edit, product_params) do
    case Catalog.update_product(socket.assigns.product, product_params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product(socket, :new_product, input_product_params) do
    business = socket.assigns.current_business

    prod_params = Product.changeset(%Product{}, input_product_params)
    |> Ecto.Changeset.apply_changes

    product_params =
      put_picture_urls(socket, prod_params)
      |> Map.from_struct

    case Catalog.create_product(business,
          product_params,
          &consume_uploaded_pictures(socket, &1)
        ) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def consume_uploaded_pictures(socket, product) do
    consume_uploaded_entries(socket, :product_image, fn meta, entry ->
      dest = Path.join(uploads_path, "#{entry.uuid}.#{ext(entry)}")
      File.cp!(meta.path, dest)
    end)
    {:ok, product}
  end

  def put_picture_urls(socket, %Product{} = product) do
    {completed, [] } = uploaded_entries(socket, :product_image)
    image_urls = for entry <- completed do
      Routes.static_path(socket, "/uploads/#{entry.uuid}.#{ext(entry)}")
    end
    %Product{product | images: image_urls}
  end

  def ext(entry) do
    [first | _] = MIME.extensions(entry.client_type)
  end

  defp uploads_path do
    Path.join([:code.priv_dir(:atmanirbhar), "static", "uploads"])
  end

end
