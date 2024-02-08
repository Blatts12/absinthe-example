defmodule AppWeb.GraphQl.Blog.PostSubscriptionsTest do
  use AppWeb.SubscriptionCase

  alias App.AccountsFixtures

  describe "post_created" do
    @create_post """
    mutation($input: CreatePostInput!) {
      createPost(input: $input) {
        id
        title
      }
    }
    """

    @post_created """
    subscription($userId: ID) {
      postCreated(userId: $userId) {
        id
        title
      }
    }
    """

    test "returns post when created" do
      socket = create_socket()
      # Subscribe to a post creation
      subscription_id = subscribe(socket, @post_created)
      user = AccountsFixtures.user_fixture()
      post_params = %{title: "valid title", user_id: user.id}

      # Trigger the subscription by creating a post
      gql_post(%{
        query: @create_post,
        variables: %{"input" => post_params}
      })

      # Check if something have been pushed to the given subscription
      assert_push "subscription:data", %{result: result, subscriptionId: ^subscription_id}

      # Pattern match the result
      assert %{
               data: %{
                 "postCreated" => %{
                   "id" => _,
                   "title" => title
                 }
               }
             } = result

      assert post_params.title == title

      # Ensure that no other pushes were sent
      refute_push "subscription:data", %{}
    end

    test "returns user when created with provided user id" do
      socket = create_socket()
      user_one = AccountsFixtures.user_fixture()
      subscription_id = subscribe(socket, @post_created, variables: %{"userId" => user_one.id})

      gql_post(%{
        query: @create_post,
        variables: %{"input" => %{title: "valid title", user_id: user_one.id}}
      })

      assert_push "subscription:data", %{result: result, subscriptionId: ^subscription_id}

      assert %{
               data: %{
                 "postCreated" => %{
                   "id" => _,
                   "title" => "valid title"
                 }
               }
             } = result

      # Ensure that no other pushes were sent
      refute_push "subscription:data", %{}
      user_two = AccountsFixtures.user_fixture()

      gql_post(%{
        query: @create_post,
        variables: %{"input" => %{title: "valid title", user_id: user_two.id}}
      })

      # Ensure that no pushes were sent
      refute_push "subscription:data", %{}
    end
  end
end
