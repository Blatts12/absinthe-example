defmodule ExAbsWeb.GraphQl.Auth.UserSubscriptions do
  @moduledoc false

  use Absinthe.Schema.Notation

  object :user_subscriptions do
    field :user_created, :user do
      trigger :create_user, topic: fn _ -> "user_created" end

      config fn _args, _resolution ->
        {:ok, topic: "user_created"}
      end

      # This is the default resolve function, so you don't need to define it if you don't want to customize it.
      # resolve fn user, _, _ ->
      #   {:ok, user}
      # end
    end
  end
end
