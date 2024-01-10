defmodule MeloChat.AuthFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MeloChat.Auth` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        username: "some username"
      })
      |> MeloChat.Auth.create_user()

    user
  end
end
