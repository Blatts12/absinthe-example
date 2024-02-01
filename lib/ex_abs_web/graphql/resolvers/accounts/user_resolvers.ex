defmodule ExAbsWeb.GraphQl.Accounts.UserResolvers do
  @moduledoc false

  alias ExAbs.Accounts.User
  alias ExAbs.Types

  @spec current_user(Types.absinthe_args(), Types.absinthe_info()) :: Types.query_result(User.t())
  def current_user(_args, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  @spec get_user(Types.absinthe_args(), Types.absinthe_info()) :: Types.query_result(User.t())
  def get_user(_args, %{context: %{resource: user}}) do
    {:ok, user}
  end
end
