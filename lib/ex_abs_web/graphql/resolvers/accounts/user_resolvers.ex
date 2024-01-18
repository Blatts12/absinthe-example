defmodule ExAbsWeb.GraphQl.Accounts.UserResolvers do
  @moduledoc false

  alias ExAbs.Accounts.User

  @spec current_user(map(), map()) :: {:ok, User.t()} | {:error, any()}
  def current_user(_args, %{context: %{current_user: user}}) do
    {:ok, user}
  end
end
