defmodule ExAbs.Accounts.UserFactory do
  @moduledoc false

  alias ExAbs.Accounts.User

  defmacro __using__(_opts) do
    quote do
      @valid_password "zaq1@WSX1234"

      def user_factory do
        %User{
          email: sequence(:email, &"user-#{&1}@example.com"),
          hashed_password: Pbkdf2.hash_pwd_salt(@valid_password)
        }
      end
    end
  end
end
