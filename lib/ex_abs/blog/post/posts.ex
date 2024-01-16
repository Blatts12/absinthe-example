defmodule ExAbs.Blog.Posts do
  @moduledoc false

  use Contexted.CRUD,
    repo: ExAbs.Repo,
    schema: ExAbs.Blog.Post
end
