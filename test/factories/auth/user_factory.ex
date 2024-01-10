defmodule MeloChat.Auth.UserFactory do
  @moduledoc false

  alias MeloChat.Auth.User

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
