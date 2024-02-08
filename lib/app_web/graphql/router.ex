defmodule AppWeb.GraphQl.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  forward "/graphql",
    to: Absinthe.Plug,
    init_opts: []

  if Application.compile_env(:app, :dev_routes) do
    forward "/graphiql",
      to: Absinthe.Plug.GraphiQL,
      init_opts: [
        interface: :playground
      ]
  end
end
