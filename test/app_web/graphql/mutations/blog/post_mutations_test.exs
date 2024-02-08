defmodule AppWeb.GraphQl.Blog.PostMutationsTest do
  use AppWeb.GraphQlCase

  alias App.AccountsFixtures

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

      image = %Plug.Upload{
        content_type: "image/png",
        filename: "sample-img.png",
        path: "./test/support/images/sample-img.png"
      }

      variables = %{
        "input" => %{
          "title" => "valid title",
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
                 image_png: image,
                 add_token_for: user
               })

      assert to_string(user.id) == user_id
    end

    test "returns error when input is invalid" do
      user = AccountsFixtures.user_fixture()

      variables = %{
        "input" => %{
          "title" => "bad"
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
                 variables: variables,
                 add_token_for: user
               })
    end
  end
end
