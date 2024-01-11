defmodule ExAbs.Auth.UserSpec do
  @moduledoc false

  alias ExAbs.Types

  @type t() :: %ExAbs.Auth.User{
          id: Types.field(Types.id()),
          username: Types.field(String.t()),
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
