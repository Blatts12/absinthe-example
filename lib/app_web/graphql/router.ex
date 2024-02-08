defmodule AppWeb.GraphQl.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  forward "/graphql",
    to: Absinthe.Plug,
    init_opts: [
      schema: AppWeb.GraphQl.Schema
    ]

  if Application.compile_env(:app, :dev_routes) do
    forward "/graphiql",
      to: Absinthe.Plug.GraphiQL,
      init_opts: [
        schema: AppWeb.GraphQl.Schema,
        interface: :playground
      ]
  end
end
