defmodule AtmanirbharWeb.Router do
  use AtmanirbharWeb, :router
  use Kaffy.Routes , scope: "/admin"

  import AtmanirbharWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AtmanirbharWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
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

  scope "/", AtmanirbharWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/new_deal", UserDashboardLive.Index, :new_deal
    live "/add-my-business", UserDashboardLive.Index, :new_business
    live "/new_advertisement", UserDashboardLive.Index, :new_advertisement
    live "/new_stall", UserDashboardLive.Index, :new_stall
    live "/edit_stall/:stall_id", UserDashboardLive.Index, :edit_stall
    live "/bulk-upload", UserDashboardLive.Index, :new_bulk_upload
    live "/pincode/:pincode", PageLive, :pincode
    live "/stall/:stall_id", StallLive.Index, :index
    # live "/marketplace_stalls/:id/edit", StallLive.Index, :edit
    # live "/shops/:id/edit", ShopLive.Index, :edit
    # live "/xstall", PageStallLive, :index

    # import
    # post "/import", BulkUploadController, :import_city_data

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

  scope "/", AtmanirbharWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated, :put_session_layout]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/login", UserSessionController, :new
    post "/users/login", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/admin", AtmanirbharWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/advertisements", AdvertisementLive.Index, :index
    live "/advertisements/new", AdvertisementLive.Index, :new
    live "/advertisements/:id/edit", AdvertisementLive.Index, :edit
    live "/advertisements/:id", AdvertisementLive.Show, :show
    live "/advertisements/:id/show/edit", AdvertisementLive.Show, :edit

    live "/deals", DealLive.Index, :index
    live "/deals/new", DealLive.Index, :new
    live "/deals/:id/edit", DealLive.Index, :edit

    live "/deals/:id", DealLive.Show, :show
    live "/deals/:id/show/edit", DealLive.Show, :edit

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

    live "/marketplace_products_deals", DealsLive.Index, :index
    live "/marketplace_products_deals/new", DealsLive.Index, :new
    live "/marketplace_products_deals/:id/edit", DealsLive.Index, :edit
    live "/marketplace_products_deals/:id", DealsLive.Show, :show
    live "/marketplace_products_deals/:id/show/edit", DealsLive.Show, :edit

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

    live "/shops", ShopLive.Index, :index
    live "/shops/new", ShopLive.Index, :new
    live "/shops/:id/edit", ShopLive.Index, :edit
    live "/shops/:id", ShopLive.Show, :show
    live "/shops/:id/show/edit", ShopLive.Show, :edit


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
  end

  scope "/", AtmanirbharWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings/update_password", UserSettingsController, :update_password
    put "/users/settings/update_email", UserSettingsController, :update_email
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
    put "/users/settings/update_avatar", UserSettingsController, :update_avatar


    live "/dashboard", UserDashboardLive.Index, :index
    live "/dashboard/new_product", UserDashboardLive.Index, :new_product

    # live "/marketplace_stalls", StallLive.Index, :index
    # live "/marketplace_stalls/new", StallLive.Index, :new
    # live "/marketplace_stalls/:id/edit", StallLive.Index, :edit

    live "/marketplace_stalls/:id", StallLive.Show, :show
    live "/marketplace_stalls/:id/show/edit", StallLive.Show, :edit

  end

  scope "/", AtmanirbharWeb do
    pipe_through [:browser]


    delete "/users/logout", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm



  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end
end
