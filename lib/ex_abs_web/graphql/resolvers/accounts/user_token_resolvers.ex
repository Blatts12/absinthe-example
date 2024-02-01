defmodule ExAbsWeb.GraphQl.Accounts.UserTokenResolvers do
  @moduledoc false

  alias ExAbs.Accounts
  alias ExAbs.Accounts.User
  alias ExAbs.Accounts.UserToken
  alias ExAbs.Types

  @spec login_user(Types.absinthe_args(), Types.absinthe_info()) :: Types.mutation_result(:user_token, UserToken.t())
  def login_user(%{email: email, password: password}, _resolution) do
    with %User{} = user <- Accounts.get_user_by_email_and_password(email, password),
         %UserToken{} = user_token <- Accounts.generate_user_session_token(user) do
      {:ok, %{user_token: user_token}}
    else
      _ ->
        {:error, :invalid_credentials}
    end
  end

  @spec register(Types.absinthe_args(), Types.absinthe_info()) :: Types.mutation_result(:user, User.t())
  def register(args, _resolution) do
    with {:ok, %User{} = user} <- Accounts.register_user(args) do
      {:ok, %{user: user}}
    end
  end

  @spec logout(Types.absinthe_args(), Types.absinthe_info()) :: Types.mutation_result(:successful, boolean())
  def logout(_args, %{context: %{token: token}}) do
    :ok = Accounts.delete_user_session_token(token)

    {:ok, %{successful: true}}
  end
end
