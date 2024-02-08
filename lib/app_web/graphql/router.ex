defmodule AppWeb.GraphQl.Router do
  use Plug.Router
  alias AppWeb.FetchUserPlug

  plug :match
  plug FetchUserPlug
  plug :dispatch

  forward "/graphql",
    to: Absinthe.Plug,
    init_opts: [
      schema: AppWeb.GraphQl.Schema,
      analyze_complexity: true,
      max_complexity: 300
    ]

  if Application.compile_env(:app, :dev_routes) do
    forward "/graphiql",
      to: Absinthe.Plug.GraphiQL,
      init_opts: [
        schema: AppWeb.GraphQl.Schema,
        socket: AppWeb.UserSocket,
        socket_url: "ws://localhost:4000/api/graphql",
        interface: :playground
      ]
  end
end
