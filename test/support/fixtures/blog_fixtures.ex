defmodule App.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> App.Blog.create_post()

    post
  end
end
