defmodule AppWeb.GraphQl.Accounts.UserTypes do
  use AppWeb.GraphQl.Schema.Type

  alias App.Blog.Post

  @desc "This is a user"
  node object(:user) do
    field :email, :string
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
    field :posts, list_of(:post), resolve: dataloader(Post)
  end
end
