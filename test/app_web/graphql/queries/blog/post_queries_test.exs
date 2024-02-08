defmodule AppWeb.GraphQl.Blog.PostQueriesTest do
  use AppWeb.GraphQlCase

  alias App.AccountsFixtures
  alias App.BlogFixtures
  alias AppWeb.GraphQl.Schema

  describe "get_post" do
    @get_post """
    query($id: ID!) {
      getPost(id: $id) {
        id
        title
      }
    }
    """

    test "returns post when found" do
      user = AccountsFixtures.user_fixture()
      post = BlogFixtures.post_fixture(%{user_id: user.id})
      post_id = Absinthe.Relay.Node.to_global_id("Post", post.id, Schema)

      assert %{
               "data" => %{
                 "getPost" => %{
                   "id" => post_id,
                   "title" => post.title
                 }
               }
             } ==
               gql_post(%{
                 query: @get_post,
                 variables: %{"id" => post.id}
               })
    end

    test "returns 'not_found' error when missing" do
      assert %{
               "data" => nil,
               "errors" => [%{"message" => "not_found"}]
             } =
               gql_post(%{
                 query: @get_post,
                 variables: %{"id" => -1}
               })
    end
  end
end
