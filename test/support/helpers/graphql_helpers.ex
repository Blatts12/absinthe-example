defmodule ExAbsWeb.GraphQlHelpers do
  @moduledoc false
  import Phoenix.ConnTest
  import Plug.Conn

  @endpoint ExAbsWeb.Endpoint

  @spec gql_post(map(), integer()) :: map()
  def gql_post(options, response \\ 200) do
    build_conn()
    |> put_resp_content_type("application/json")
    |> post("/api/graphql", options)
    |> json_response(response)
  end
end
