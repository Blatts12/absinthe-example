defmodule ExAbsWeb.Router do
  use ExAbsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExAbsWeb do
    forward "/api", GraphQl.Router
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ex_abs, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ExAbsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
