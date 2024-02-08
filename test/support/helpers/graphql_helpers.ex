defmodule AppWeb.GraphQlHelpers do
  import Phoenix.ConnTest
  import Plug.Conn

  alias App.Accounts
  alias App.Accounts.User

  # Required by the post function from Phoenix.ConnTest
  @endpoint AppWeb.Endpoint

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
    user_token = Accounts.generate_user_session_token(user)
    put_req_header(conn, "authorization", "Bearer #{user_token.token}")
  end

  defp add_token_for_user(conn, %{add_token_for: token}) when is_binary(token) do
    put_req_header(conn, "authorization", "Bearer #{token}")
  end

  defp add_token_for_user(conn, _options), do: conn
end
