defmodule AtmanirbharWeb.Router do
  use AtmanirbharWeb, :router
  use Kaffy.Routes , scope: "/admin"

  import AtmanirbharWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :marketplace do
    plug :put_root_layout, {AtmanirbharWeb.LayoutView, :root}
  end

  pipeline :user_dashboard do
    plug :put_root_layout, {AtmanirbharWeb.LayoutView, :user_dashboard}
  end

  pipeline :store do
    plug :put_root_layout, {AtmanirbharWeb.LayoutView, :store_layout}
  end

  # Admin Dashboard
  pipeline :kaffy_browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    # plug :put_root_layout, {AtmanirbharWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :require_authenticated_user
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  # Other scopes may use custom stacks.
  scope "/api", AtmanirbharWeb do
    pipe_through :api

    post "/session", SessionController, :set
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/live_dashboard", metrics: AtmanirbharWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/accounts", AtmanirbharWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated, :put_session_layout]

    get "/signup", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/signin", UserSessionController, :new
    post "/users/login", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/admin", AtmanirbharWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/locations", LocationLive.Index, :index
    live "/locations/new", LocationLive.Index, :new
    live "/locations/:id/edit", LocationLive.Index, :edit
    live "/locations/:id", LocationLive.Show, :show
    live "/locations/:id/show/edit", LocationLive.Show, :edit


    live "/businesses", BusinessLive.Index, :index
    live "/businesses/new", BusinessLive.Index, :new
    live "/businesses/:id/edit", BusinessLive.Index, :edit
    live "/businesses/:id", BusinessLive.Show, :show
    live "/businesses/:id/show/edit", BusinessLive.Show, :edit

    live "/catalog_blueprints", BlueprintLive.Index, :index
    live "/catalog_blueprints/new", BlueprintLive.Index, :new
    live "/catalog_blueprints/:id/edit", BlueprintLive.Index, :edit
    live "/catalog_blueprints/:id", BlueprintLive.Show, :show
    live "/catalog_blueprints/:id/show/edit", BlueprintLive.Show, :edit

    live "/marketplace_products", ProductLive.Index, :index
    live "/marketplace_products/new", ProductLive.Index, :new
    live "/marketplace_products/:id/edit", ProductLive.Index, :edit

    live "/marketplace_products/:id", ProductLive.Show, :show
    live "/marketplace_products/:id/show/edit", ProductLive.Show, :edit

    live "/marketplace_bulk_uploads", BulkUploadLive.Index, :index
    live "/marketplace_bulk_uploads/new", BulkUploadLive.Index, :new
    live "/marketplace_bulk_uploads/:id/edit", BulkUploadLive.Index, :edit

    live "/marketplace_bulk_uploads/:id", BulkUploadLive.Show, :show
    live "/marketplace_bulk_uploads/:id/show/edit", BulkUploadLive.Show, :edit

    live "/pincodes", PincodeLive.Index, :index
    live "/pincodes/new", PincodeLive.Index, :new
    live "/pincodes/:id/edit", PincodeLive.Index, :edit

    live "/pincodes/:id", PincodeLive.Show, :show
    live "/pincodes/:id/show/edit", PincodeLive.Show, :edit

    live "/cities", CityLive.Index, :index
    live "/cities/new", CityLive.Index, :new
    live "/cities/:id/edit", CityLive.Index, :edit

    live "/cities/:id", CityLive.Show, :show
    live "/cities/:id/show/edit", CityLive.Show, :edit

    live "/resources", RawMaterialLive.Index, :index
    live "/raw_materials/new", RawMaterialLive.Index, :new
    live "/raw_materials/:id/edit", RawMaterialLive.Index, :edit

    live "/raw_materials/:id", RawMaterialLive.Show, :show
    live "/raw_materials/:id/show/edit", RawMaterialLive.Show, :edit

    live "/catalog_taxonomies", TaxonomyLive.Index, :index
    live "/catalog_taxonomies/new", TaxonomyLive.Index, :new
    live "/catalog_taxonomies/:id/edit", TaxonomyLive.Index, :edit

    live "/catalog_taxonomies/:id", TaxonomyLive.Show, :show
    live "/catalog_taxonomies/:id/show/edit", TaxonomyLive.Show, :edit
    live "/marketplace_stalls/:id", StallLive.Show, :show
    live "/marketplace_stalls/:id/show/edit", StallLive.Show, :edit
  end

  scope "/dashboard", AtmanirbharWeb do
    pipe_through [:browser, :require_authenticated_user, :user_dashboard]

    get "/settings", UserSettingsController, :edit
    put "/settings/update_password", UserSettingsController, :update_password
    put "/settings/update_email", UserSettingsController, :update_email
    get "/settings/confirm_email/:token", UserSettingsController, :confirm_email
    put "/settings/update_avatar", UserSettingsController, :update_avatar


    live "/", UserDashboardLive.Index, :index

    live "/add-my-business", UserDashboardLive.Index, :new_business
    live "/edit-business", UserDashboardLive.Index, :edit_business

    live "/stalls", UserDashboardLive.Stalls, :stalls
    live "/new_stall", UserDashboardLive.Index, :new_stall
    live "/edit-stall/:stall_id", UserDashboardLive.Index, :edit_stall
    live "/edit-stall-media/:stall_id", UserDashboardLive.Index, :edit_stall_media

    live "/gallery", UserDashboardLive.Gallery, :gallery
    live "/gallery/new_picture", UserDashboardLive.Gallery, :new_picture

    live "/catalog", UserDashboardLive.Catalog, :index
    live "/catalog/new_product", UserDashboardLive.Catalog, :new_product

    live "/bulk-upload", UserDashboardLive.Index, :new_bulk_upload
  end

  scope "/", AtmanirbharWeb do
    pipe_through [:browser]

    delete "/users/logout", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm

  end

  scope "/", AtmanirbharWeb do
    pipe_through [:browser, :marketplace]

    live "/", PageLive, :index
    live "/pincode/:pincode", PageLive, :pincode
  end

  scope "/", AtmanirbharWeb do
    pipe_through [:browser, :store]

    # live "/:stall_id", StallPublicLive, :index
    live "/:store_id", StorePublicLive, :index
  end

  scope "/pages", AtmanirbharWeb do
    pipe_through [:browser, :marketplace]

    live "/faqs", FaqsLive, :index
  end


  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end
end
