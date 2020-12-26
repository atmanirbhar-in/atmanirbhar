defmodule AtmanirbharWeb.UserDashboardLive.TimelinePostFormComponent do
  use AtmanirbharWeb, :live_component

  alias Atmanirbhar.Marketplace
  alias Atmanirbhar.Marketplace.{StallElement, Stall}

  @impl true
  def update(%{stall_element: stall_element} = assigns, socket) do
    changeset = Marketplace.change_timeline_post(stall_element)
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"stall_element" => timeline_params}, socket) do
    changeset =
      socket.assigns.stall_element
      |> Marketplace.change_timeline_post(timeline_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"stall_element" => timeline_params}, socket) do
    save_timeline_post(socket, socket.assigns.action, timeline_params)
  end

  defp save_timeline_post(socket, :edit, timeline_post_params) do
    case Marketplace.update_timeline_post(socket.assigns.timeline_post, timeline_post_params) do
      {:ok, _timeline_post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Timeline_Post updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_timeline_post(socket, :new_timeline_post, timeline_post_params) do
    case Marketplace.create_timeline_post(timeline_post_params) do
      {:ok, _timeline_post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Timeline_Post created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
