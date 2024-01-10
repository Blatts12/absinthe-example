defmodule MeloChat.Auth.UserSpec do
  @moduledoc false

  alias MeloChat.Types

  @type t() :: %MeloChat.Auth.User{
          id: Types.field(Types.id()),
          username: Types.field(String.t()),
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
