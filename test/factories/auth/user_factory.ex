defmodule ExAbs.Auth.UserFactory do
  @moduledoc false

  alias ExAbs.Auth.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          username: sequence(:username, &"username-#{&1}")
        }
      end
    end
  end
end
