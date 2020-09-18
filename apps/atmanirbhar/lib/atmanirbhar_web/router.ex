defmodule AtmanirbharWeb.Router do
  use AtmanirbharWeb, :router
  use Kaffy.Routes #, scope: "/admin", pipe_through: [:some_plug, :authenticate]

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

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AtmanirbharWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", AtmanirbharWeb do
  #   pipe_through :api
  # end

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

  scope "/", AtmanirbharWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings/update_password", UserSettingsController, :update_password
    put "/users/settings/update_email", UserSettingsController, :update_email
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
    put "/users/settings/update_avatar", UserSettingsController, :update_avatar

    live "/dashboard", UserDashboardLive.Index, :index

  end

  scope "/", AtmanirbharWeb do
    pipe_through [:browser]

    delete "/users/logout", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm

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

    live "/advertisements", AdvertisementLive.Index, :index
    live "/advertisements/new", AdvertisementLive.Index, :new
    live "/advertisements/:id/edit", AdvertisementLive.Index, :edit
    live "/advertisements/:id", AdvertisementLive.Show, :show
    live "/advertisements/:id/show/edit", AdvertisementLive.Show, :edit



  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end
end
