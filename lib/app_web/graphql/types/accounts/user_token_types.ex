defmodule AppWeb.GraphQl.Accounts.UserTokenTypes do
  use AppWeb.GraphQl.Schema.Type

  node object(:user_token) do
    field :token, non_null(:string)
    field :user_id, non_null(:id)
    field :user, non_null(:user), resolve: dataloader(:basic)
  end
end
