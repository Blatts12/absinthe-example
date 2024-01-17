defmodule ExAbsWeb.FetchUserPlug do
  @moduledoc false

  @behaviour Plug

  import Plug.Conn

  alias ExAbs.Auth
  alias ExAbs.Auth.User

  @spec init(Keyword.t()) :: Keyword.t()
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def call(conn, _opts) do
    with ["Bearer " <> user_id] <- get_req_header(conn, "authorization"),
         %User{} = user <- Auth.get_user(user_id) do
      Absinthe.Plug.assign_context(conn, :current_user, user)
    else
      _user_id_missing_or_incorrect -> conn
    end
  end
end
