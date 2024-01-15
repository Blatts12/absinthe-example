defmodule ExAbs.Blog.PostSpec do
  @moduledoc false

  alias ExAbs.Auth.User
  alias ExAbs.Types

  @type t() :: %ExAbs.Blog.Post{
          id: Types.field(Types.id()),
          title: Types.field(String.t()),
          user_id: Types.field(Types.id()),
          user: Types.field(User.t()),
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
