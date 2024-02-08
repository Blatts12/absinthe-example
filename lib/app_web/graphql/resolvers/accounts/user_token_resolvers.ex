defmodule AppWeb.GraphQl.Accounts.UserTokenResolvers do
  alias App.Accounts
  alias App.Accounts.User
  alias App.Accounts.UserToken

  def register(args, _resolution) do
    with {:ok, %User{} = user} <- Accounts.register_user(args) do
      {:ok, %{user: user}}
    end
  end

  def login_user(%{email: email, password: password}, _resolution) do
    with %User{} = user <- Accounts.get_user_by_email_and_password(email, password),
         %UserToken{} = user_token <- Accounts.generate_user_session_token(user) do
      {:ok, %{user_token: user_token}}
    else
      _ ->
        {:error, :invalid_credentials}
    end
  end

  def logout(_args, %{context: %{token: token}}) do
    :ok = Accounts.delete_user_session_token(token)

    {:ok, %{successful: true}}
  end
end
