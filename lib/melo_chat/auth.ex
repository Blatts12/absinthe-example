defmodule MeloChat.Auth do
  @moduledoc false

  import Contexted.Delegator

  alias MeloChat.Auth.Users

  delegate_all(Users)
end
