defmodule AtmanirbharWeb.UserDashboardLive.Index do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace.Advertisement

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket,
        my_plugins: []
      )
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit config")
    # |> assign(:advertisement, Marketplace.get_advertisement!(id))
  end

  defp apply_action(socket, :index, %{}) do
    socket
    |> assign(:page_title, "Edit config")
    # |> assign(:advertisement, Marketplace.get_advertisement!(id))
  end

  defp apply_action(socket, :new_ad, _params) do
    socket
    |> assign(:page_title, "New Advertisement")
    |> assign(:advertisement, %Advertisement{})
  end


end
