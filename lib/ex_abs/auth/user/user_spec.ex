defmodule ExAbs.Auth.UserSpec do
  @moduledoc false

  alias ExAbs.Blog.Post
  alias ExAbs.Types

  @type t() :: %ExAbs.Auth.User{
          id: Types.field(Types.id()),
          username: Types.field(String.t()),
          avatar: Types.field(String.t()),
          posts: Types.field(list(Post.t())),
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
