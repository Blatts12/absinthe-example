defmodule ExAbs.Accounts.UserTokenSpec do
  @moduledoc false

  alias ExAbs.Accounts.User
  alias ExAbs.Accounts.UserToken
  alias ExAbs.Types

  @type t() :: %UserToken{
          id: Types.field(Types.id()),
          context: Types.field(String.t()),
          sent_to: Types.field(String.t()),
          token: Types.field(String.t() | binary()),
          user_id: Types.field(Types.id()),
          user: Types.assoc_field(User.t()),
          inserted_at: Types.field(DateTime.t())
        }
end
