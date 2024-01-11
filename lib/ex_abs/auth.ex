defmodule ExAbs.Auth do
  @moduledoc false

  import Contexted.Delegator

  alias ExAbs.Auth.Users

  delegate_all(Users)
end
