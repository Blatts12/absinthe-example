defmodule ExAbsWeb.GraphQl.Auth.UserSubscriptions do
  @moduledoc false

  use Absinthe.Schema.Notation

  object :user_subscriptions do
    field :user_created, :user do
      arg :username, :string

      trigger :create_user, topic: fn user -> ["user_created", "user_created:#{user.username}"] end

      config fn args, _resolution ->
        if Map.has_key?(args, :username) do
          {:ok, topic: "user_created:#{Map.get(args, :username)}"}
        else
          {:ok, topic: "user_created"}
        end

        # Multiple topics can be returned as a list
        # {:ok, topic: ["user_created", "user_created:#{Map.get(args, :username)}"]
      end

      # This is the default resolve function, so you don't need to define it if you don't want to customize it.
      # resolve fn user, _, _ ->
      #   {:ok, user}
      # end
    end
  end
end
