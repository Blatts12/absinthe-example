defmodule ExAbs.Accounts.UserTokenFactory do
  @moduledoc false

  alias ExAbs.Accounts.UserToken

  defmacro __using__(_opts) do
    quote do
      def user_token_factory do
        %UserToken{
          token:
            32
            |> :crypto.strong_rand_bytes()
            |> Base.url_encode64(padding: false),
          context: "session",
          user: build(:user)
        }
      end
    end
  end
end
