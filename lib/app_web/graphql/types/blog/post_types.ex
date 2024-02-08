defmodule AppWeb.GraphQl.Blog.PostTypes do
  use AppWeb.GraphQl.Schema.Type

  @desc "You can describe enums as well"
  enum :post_type do
    value :announcement
    value :advertisement
    value :tutorial, as: "GUIDE"
  end

  node object(:post) do
    field :title, :string
    field :user_id, non_null(:id)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :type, :post_type
    field :user, non_null(:user), resolve: dataloader(:basic)
  end

  connection(node_type: :post)
end
