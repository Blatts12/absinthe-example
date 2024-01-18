defmodule ExAbsWeb.GraphQlHelpers do
  @moduledoc false

  import Phoenix.ConnTest
  import Plug.Conn

  alias ExAbs.Accounts
  alias ExAbs.Accounts.User

  @endpoint ExAbsWeb.Endpoint

  @spec gql_post(map(), integer()) :: map()
  def gql_post(options, response \\ 200) do
    post_options = Map.drop(options, [:add_token_for])

    build_conn()
    |> put_resp_content_type("application/json")
    |> add_token_for_user(options)
    |> post("/api/graphql", post_options)
    |> json_response(response)
  end

  @spec add_token_for_user(Plug.Conn.t(), map()) :: Plug.Conn.t()
  defp add_token_for_user(conn, %{add_token_for: %User{} = user}) do
    %{token: token} = Accounts.generate_user_session_token(user)

    put_req_header(conn, "authorization", "Bearer #{token}")
  end

  defp add_token_for_user(conn, %{add_token_for: token}) when is_binary(token) do
    put_req_header(conn, "authorization", "Bearer #{token}")
  end

  defp add_token_for_user(conn, _options), do: conn
end
