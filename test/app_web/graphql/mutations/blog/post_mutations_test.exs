defmodule AppWeb.GraphQl.Blog.PostMutationsTest do
  use AppWeb.GraphQlCase

  alias App.AccountsFixtures
  alias AppWeb.GraphQl.Schema

  describe "create_post" do
    @create_post """
    mutation($input: CreatePostInput!) {
      createPost(input: $input) {
        post {
          id
          title
          userId
        }
      }
    }
    """

    test "creates post when input is valid" do
      user = AccountsFixtures.user_fixture()
      user_id = Absinthe.Relay.Node.to_global_id("User", user.id, Schema)

      image = %Plug.Upload{
        content_type: "image/png",
        filename: "sample-img.png",
        path: "./test/support/images/sample-img.png"
      }

      variables = %{
        "input" => %{
          "title" => "valid title",
          "userId" => user_id,
          "image" => "image_png"
        }
      }

      assert %{
               "data" => %{
                 "createPost" => %{
                   "post" => %{
                     "id" => _,
                     "title" => "valid title",
                     "userId" => user_id
                   }
                 }
               }
             } =
               gql_post(%{
                 query: @create_post,
                 variables: variables,
                 image_png: image
               })

      assert to_string(user.id) == user_id
    end

    test "returns error when input is invalid" do
      user = AccountsFixtures.user_fixture()
      user_id = Absinthe.Relay.Node.to_global_id("User", user.id, Schema)

      variables = %{
        "input" => %{
          "title" => "bad",
          "userId" => user_id
        }
      }

      assert %{
               "data" => %{"createPost" => nil},
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
