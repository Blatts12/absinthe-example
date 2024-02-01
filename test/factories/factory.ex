defmodule ExAbs.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: ExAbs.Repo

  # Accounts
  use ExAbs.Accounts.UserFactory
  use ExAbs.Accounts.UserTokenFactory
end
