defmodule AppWeb.GraphQl.Blog.PostMutationsTest do
  use AppWeb.GraphQlCase

  alias App.AccountsFixtures

  describe "create_post" do
    @create_post """
    mutation($input: CreatePostInput!) {
      createPost(input: $input) {
        id
        title
        userId
      }
    }
    """

    test "creates post when input is valid" do
      user = AccountsFixtures.user_fixture()

      variables = %{
        "input" => %{
          "title" => "valid title",
          "userId" => user.id
        }
      }

      assert %{
               "data" => %{
                 "createPost" => %{
                   "id" => _,
                   "title" => "valid title",
                   "userId" => user_id
                 }
               }
             } =
               gql_post(%{
                 query: @create_post,
                 variables: variables
               })

      assert to_string(user.id) == user_id
    end

    test "returns error when input is invalid" do
      user = AccountsFixtures.user_fixture()

      variables = %{
        "input" => %{
          "title" => "bad",
          "userId" => user.id
        }
      }

      assert %{
               "data" => nil,
               "errors" => [
                 %{
                   "message" => "should be at least 4 character(s)",
                   "details" => %{"field" => ["title"]}
                 }
               ]
             } =
               gql_post(%{
                 query: @create_post,
                 variables: variables
               })
    end
  end
end
