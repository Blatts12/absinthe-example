defmodule ExAbs.Accounts do
  @moduledoc false

  import Contexted.Delegator

  alias ExAbs.Accounts.Users
  alias ExAbs.Accounts.UserTokens

  delegate_all(Users)
  delegate_all(UserTokens)
end
