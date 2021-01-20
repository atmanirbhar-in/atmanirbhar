defmodule AtmanirbharWeb.UserDashboardLive.FolderComponent do
  use AtmanirbharWeb, :live_component

  # def update(socket, assigns) do
  #   {:ok,
  #    socket
  #    |> assign(assigns)
  #   }
  # end

  def render(assigns) do
    ~L"""
    <div class="
    <%= if @live_action in @highlight_actions do %>
    w-40 h-40
    bg-gray-300
    <% else %>
    w-40 h-40
    <% end %>
    ">
    <%= live_patch to: @folder_link,
    class: "btn btn-link w-full" do %>
    <%= img_tag(@folder_poster) %>
    <p class="leading-relaxed bg-white"><%= @folder_title %></p>
    <% end %>
    </div>
    """
  end

  # defp folder_poster_filename do
  #   Routes.static_path(@socket, "/images/dashboard/<%= @folder_poster) %>")
  # end

end
