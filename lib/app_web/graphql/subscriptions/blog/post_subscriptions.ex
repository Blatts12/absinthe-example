defmodule AppWeb.GraphQl.Blog.PostSubscriptions do
  use AppWeb.GraphQl.Schema.Type

  object :post_subscriptions do
    field :post_created, non_null(:post) do
      arg :user_id, :id

      config fn args, _resolution ->
        case args do
          %{user_id: user_id} ->
            {:ok, topic: "post_created:#{user_id}"}

          _ ->
            {:ok, topic: "post_created"}
        end
      end

      trigger :create_post,
        topic: fn %{post: %{user_id: user_id}} ->
          ["post_created", "post_created:#{user_id}"]
        end

      resolve fn %{post: post}, _args, _resolution ->
        {:ok, post}
      end
    end
  end
end
