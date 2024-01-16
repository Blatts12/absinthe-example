defmodule ExAbsWeb.GraphQl.Auth.UserSubscriptionsTest do
  use ExAbsWeb.SubscriptionCase

  describe "user_created" do
    @create_user """
    mutation createUser($input: CreateUserInput!) {
      createUser(input: $input) {
        user {
          id
          username
        }
      }
    }
    """

    @user_created """
    subscription userCreated($username: String) {
      userCreated(username: $username) {
        id
        username
      }
    }
    """

    test "returns user when created" do
      socket = create_socket()
      subscription_id = subscribe(socket, @user_created)
      user_params = params_for(:user)

      gql_post(%{
        "query" => @create_user,
        "variables" => %{"input" => user_params}
      })

      assert_push "subscription:data", %{result: result, subscriptionId: ^subscription_id}

      assert %{
               data: %{
                 "userCreated" => %{
                   "id" => _,
                   "username" => username
                 }
               }
             } = result

      assert user_params.username == username

      # Ensure that no other pushes were sent
      refute_push "subscription:data", %{}

      # Socket will be closed automatically but we can do it manually
      # It's useful when we want to test, for example, users with different roles in a loop
      # :ok = close_socket(socket)
    end

    test "returns user when created with provided username" do
      socket = create_socket()
      subscription_id = subscribe(socket, @user_created, variables: %{"username" => "name-one"})

      gql_post(%{
        "query" => @create_user,
        "variables" => %{"input" => params_for(:user, username: "name-one")}
      })

      assert_push "subscription:data", %{result: result, subscriptionId: ^subscription_id}

      assert %{
               data: %{
                 "userCreated" => %{
                   "id" => _,
                   "username" => "name-one"
                 }
               }
             } = result

      # Ensure that no other pushes were sent
      refute_push "subscription:data", %{}

      gql_post(%{
        "query" => @create_user,
        "variables" => %{"input" => params_for(:user, username: "name-two")}
      })

      # Ensure that no pushes were sent
      refute_push "subscription:data", %{}
    end
  end
end
