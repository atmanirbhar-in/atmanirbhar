defmodule AtmanirbharWeb.UserDashboardLive.Stalls do
  use AtmanirbharWeb, :live_view
  alias Atmanirbhar.Marketplace
  alias AtmanirbharWeb.UserDashboardLive.FoldersNavigationComponent

  def mount(params, session, socket) do
    user_token =
      session
      |> Map.get("user_token")

    user_businesses_n_stalls =
      user_token
      |> Atmanirbhar.Marketplace.list_user_businesses()
      |> Enum.group_by(&Map.get(&1, :business))

    {:ok,
     socket
     |> assign(businesses_kv: user_businesses_n_stalls)}
  end
end
