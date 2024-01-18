defmodule ExAbsWeb.GraphQl.Accounts.UserTokenResolvers do
  @moduledoc false

  alias ExAbs.Accounts
  alias ExAbs.Accounts.User
  alias ExAbs.Accounts.UserToken

  @spec login_user(map(), map()) :: {:ok, UserToken.t()} | {:error, term()}
  def login_user(%{email: email, password: password}, _resolution) do
    with %User{} = user <- Accounts.get_user_by_email_and_password(email, password),
         %UserToken{} = user_token <- Accounts.generate_user_session_token(user) do
      {:ok, %{user_token: user_token}}
    else
      _ ->
        {:error, :invalid_credentials}
    end
  end

  @spec register(map(), map()) :: {:ok, %{user: User.t()}} | {:error, any()}
  def register(args, _resolution) do
    with {:ok, %User{} = user} <- Accounts.register_user(args) do
      {:ok, %{user: user}}
    end
  end

  @spec logout(map(), map()) :: {:ok, %{successful: boolean()}} | {:error, any()}
  def logout(_args, %{context: %{token: token}}) do
    :ok = Accounts.delete_user_session_token(token)

    {:ok, %{successful: true}}
  end
end
