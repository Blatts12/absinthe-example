defmodule ExAbsWeb.FetchUserPlug do
  @moduledoc false

  @behaviour Plug

  import Plug.Conn

  alias ExAbs.Accounts
  alias ExAbs.Accounts.User

  @spec init(Keyword.t()) :: Keyword.t()
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         %User{} = user <- Accounts.get_user_by_session_token(token) do
      Absinthe.Plug.assign_context(conn, %{current_user: user, token: token})
    else
      _user_id_missing_or_incorrect -> conn
    end
  end
end
