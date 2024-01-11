defmodule ExAbs.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: ExAbs.Repo

  # Auth
  use ExAbs.Auth.UserFactory
end
