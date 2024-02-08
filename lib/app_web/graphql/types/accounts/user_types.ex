defmodule AppWeb.GraphQl.Accounts.UserTypes do
  use AppWeb.GraphQl.Schema.Type

  alias AppWeb.GraphQl.Blog.PostResolvers

  @desc "This is a user"
  object :user do
    @desc "This is the user's id"
    field :id, non_null(:id)
    field :email, :string
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)

    # field :posts, list_of(:post), resolve: &list_posts/3
    field :posts, list_of(:post) do
      arg :date, :date
      resolve &PostResolvers.list_posts/3
    end
  end
end
