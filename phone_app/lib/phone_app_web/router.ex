#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneAppWeb.Router do
  use PhoneAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhoneAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoneAppWeb do
    pipe_through :browser

    get "/", PageController, :home
  end


  scope "/", PhoneAppWeb do
    pipe_through :browser

    get "/messages", MessageController, :index
    get "/messages/new", MessageController, :new
    post "/messages/new", MessageController, :create
    get "/messages/:contact_id", MessageController, :show
  end


  scope "/webhook", PhoneAppWeb.Webhook do
    pipe_through [:api]

    post "/sms", TwilioController, :sms
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phone_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhoneAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

end

