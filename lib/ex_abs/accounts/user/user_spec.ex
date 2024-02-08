defmodule ExAbs.Accounts.UserSpec do
  @moduledoc false

  alias ExAbs.Accounts.User
  alias ExAbs.Types

  @type t() :: %User{
          id: Types.field(Types.id()),
          email: Types.field(String.t()),
          hashed_password: Types.field(String.t()),
          confirmed_at: Types.field(NaiveDateTime.t()),
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
