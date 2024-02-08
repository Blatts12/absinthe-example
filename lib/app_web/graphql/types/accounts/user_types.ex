defmodule AppWeb.GraphQl.Accounts.UserTypes do
  use AppWeb.GraphQl.Schema.Type

  alias App.Blog.Post

  @desc "This is a user"
  object :user do
    @desc "This is the user's id"
    field :id, non_null(:id)
    field :email, :string
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
    field :posts, list_of(:post), resolve: dataloader(Post)
  end
end
