defmodule AtmanirbharWeb.UserDashboardLive.FoldersNavigationComponent do
  use AtmanirbharWeb, :live_component
  alias AtmanirbharWeb.UserDashboardLive.FolderComponent

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
    }
  end

  def render(assigns) do
    ~L"""

    <section class="text-gray-600 body-font">
    <div class="container px-5 py-4 mx-auto">
    <div class="flex flex-wrap -m-4 text-center">


      <%= live_component @socket, FolderComponent,
          highlight_actions: [:index],
          live_action: @live_action,
          folder_title: "Dashboard",
          folder_link: Routes.user_dashboard_index_path(@socket, :index),
          folder_poster: Routes.static_path(@socket, "/images/dashboard/dashboard_folder.png")
          %>

      <%= live_component @socket, FolderComponent,
          highlight_actions: [:gallery],
          live_action: @live_action,
          folder_title: "Gallery",
          folder_link: Routes.user_dashboard_gallery_path(@socket, :gallery),
          folder_poster: Routes.static_path(@socket, "/images/dashboard/pictures_folder.png")
          %>


      <%= live_component @socket, FolderComponent,
          highlight_actions: [:products],
          live_action: @live_action,
          folder_title: "Products & Services",
          folder_link: Routes.user_dashboard_index_path(@socket, :index),
          folder_poster: Routes.static_path(@socket, "/images/dashboard/products_folder.png")
          %>

      <%= live_component @socket, FolderComponent,
          highlight_actions: [:stalls],
          live_action: @live_action,
          folder_title: "Stalls",
          folder_link: Routes.user_dashboard_stalls_path(@socket, :stalls),
          folder_poster: Routes.static_path(@socket, "/images/dashboard/stalls_folder.png")
          %>

      <%= live_component @socket, FolderComponent,
          highlight_actions: [:social_media],
          live_action: @live_action,
          folder_title: "Social Media Posters",
          folder_link: Routes.user_dashboard_index_path(@socket, :index),
          folder_poster: Routes.static_path(@socket, "/images/dashboard/smedia_folder.png")
          %>

      <%= live_component @socket, FolderComponent,
          highlight_actions: [:tutorials],
          live_action: @live_action,
          folder_title: "Tutorials",
          folder_link: Routes.user_dashboard_index_path(@socket, :index),
          folder_poster: Routes.static_path(@socket, "/images/dashboard/smedia_folder.png")
          %>

    </div>
    </div>
    </section>
    """
  end

end
