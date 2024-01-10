defmodule MeloChat.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: MeloChat.Repo

  # Auth
  use MeloChat.Auth.UserFactory
end
