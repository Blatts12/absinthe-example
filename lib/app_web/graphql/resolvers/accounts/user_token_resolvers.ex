defmodule AppWeb.GraphQl.Accounts.UserTokenResolvers do
  alias App.Accounts
  alias App.Accounts.User

  def register(args, _resolution) do
    with {:ok, %User{} = user} <- Accounts.register_user(args) do
      {:ok, %{user: user}}
    end
  end
end
