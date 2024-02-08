defmodule AppWeb.GraphQl.Blog.PostSubscriptions do
  use Absinthe.Schema.Notation

  object :post_subscriptions do
    field :post_created, non_null(:post) do
      config fn _args, _resolution ->
        {:ok, topic: "post_created"}
      end

      trigger :create_post, topic: fn _ -> "post_created" end
    end
  end
end
