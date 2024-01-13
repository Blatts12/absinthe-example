defmodule ExAbsWeb.GraphQl.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  forward "/graphql",
    to: Absinthe.Plug,
    init_opts: [
      schema: ExAbsWeb.GraphQl.Schema
    ]

  if Mix.env() === :dev do
    forward "/graphiql",
      to: Absinthe.Plug.GraphiQL,
      init_opts: [
        schema: ExAbsWeb.GraphQl.Schema,
        socket: MyAppWeb.UserSocket,
        socket_url: "ws://localhost:4000/api/graphql",
        interface: :playground
      ]
  end
end
