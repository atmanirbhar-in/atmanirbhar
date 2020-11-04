defmodule AtmanirbharWeb.PincodeChannel do
  use AtmanirbharWeb, :channel
  alias AtmanirbharWeb.Presence

  # reference
  # https://fullstackphoenix.com/tutorials/phoenix-presence-with-phoenix-liveview

  def join("marketplace:" <> pincode, _params, socket) do
    send(self(), :after_join)
    # {:ok, socket}
    {:ok, %{}, socket}
  end

  # def handle_info(:after_join, socket) do
  #   {:ok, _} = Presence.track(socket, 123, %{
  #         online_at: inspect(System.system_time(:second))
  #                             })
  #   push(socket, "presence_state", Presence.list(socket))
  #   {:noreply, socket}
  # end

  def handle_info(:after_join, socket = %{assigns: %{user_id: nil}}) do
    {:ok, _} = Presence.track(socket, :viewers, %{})
    push_presence_state(socket)
    {:noreply, socket}
  end

  @doc """
  Register a user connection in presence tracker
  """
  def handle_info(:after_join, socket = %{assigns: %{user_id: user_id}}) do
    {:ok, _} = Presence.track(socket, :users, %{user_id: user_id})
    push_presence_state(socket)
    {:noreply, socket}
  end

  defp push_presence_state(socket) do
    push(socket, "presence_state", Presence.list(socket))
  end

end
