defmodule AppWeb.GraphQl.Blog.PostTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [batch: 3]

  alias AppWeb.GraphQl.Accounts.UserResolvers

  @desc "You can describe enums as well"
  enum :post_type do
    value :announcement
    value :advertisement
    value :tutorial, as: "GUIDE"
  end

  object :post do
    field :title, :string
    field :id, non_null(:id)
    field :user_id, non_null(:id)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :type, :post_type

    field :user, non_null(:user) do
      resolve fn post, _args, _resolution ->
        batch({UserResolvers, :list_users_by_ids, User}, post.user_id, fn batch_results ->
          {:ok, Map.get(batch_results, post.user_id)}
        end)
      end
    end
  end

  object :post_pagination do
    field :entries, list_of(:post)
    field :metadata, :pagination_metadata
  end

  input_object :create_post_input do
    field :title, non_null(:string)
    field :user_id, non_null(:id)
  end
end
