defmodule ExAbsWeb.GraphQl.Accounts.UserTokenTypes do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbs.Accounts.User

  node object(:user_token) do
    field :token, non_null(:string)
    field :user_id, non_null(:id)
    field :user, non_null(:user), resolve: dataloader(User)
  end
end
