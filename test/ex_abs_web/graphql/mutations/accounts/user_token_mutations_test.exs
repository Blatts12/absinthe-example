defmodule ExAbsWeb.GraphQl.Accounts.UserTokenMutationsTest do
  use ExAbsWeb.GraphQlCase

  alias ExAbs.Accounts
  alias ExAbs.AccountsFixtures

  describe "login" do
    @login """
      mutation($input: LoginInput!) {
        login(input: $input) {
          userToken {
            id
            token
          }
        }
      }
    """

    test "returns a user token with valid credentials" do
      user = AccountsFixtures.user_fixture(%{password: "zaq1@WSX1234"})

      %{"data" => %{"login" => %{"userToken" => %{"id" => _, "token" => token}}}} =
        gql_post(%{
          query: @login,
          variables: %{
            "input" => %{
              "email" => user.email,
              "password" => "zaq1@WSX1234"
            }
          }
        })

      assert Accounts.get_user_by_session_token(token)
    end

    test "returns invalid_credentials error with invalid credentials" do
      %{
        "data" => %{"login" => nil},
        "errors" => [%{"message" => "invalid_credentials"}]
      } =
        gql_post(%{
          query: @login,
          variables: %{
            "input" => %{
              "email" => "testing@example.com",
              "password" => "zaq1@WSX1234"
            }
          }
        })
    end

    test "returns forbidden error when user is logged in" do
      user = AccountsFixtures.user_fixture()

      %{
        "data" => %{"login" => nil},
        "errors" => [%{"message" => "forbidden"}]
      } =
        gql_post(%{
          add_token_for: user,
          query: @login,
          variables: %{
            "input" => %{
              "email" => "testing@example.com",
              "password" => "zaq1@WSX1234"
            }
          }
        })
    end
  end

  describe "register" do
    @register """
      mutation($input: RegisterInput!) {
        register(input: $input) {
          user {
            id
            email
          }
        }
      }
    """

    test "returns user with valid input" do
      variables = %{
        "input" => %{
          "email" => AccountsFixtures.unique_user_email(),
          "password" => AccountsFixtures.valid_user_password()
        }
      }

      %{"data" => %{"register" => %{"user" => %{"id" => _, "email" => _}}}} =
        gql_post(%{query: @register, variables: variables})
    end

    test "returns errors with invalid input" do
      variables = %{
        "input" => %{
          "email" => AccountsFixtures.unique_user_email(),
          "password" => "invalid"
        }
      }

      %{
        "data" => %{"register" => nil},
        "errors" => [
          %{
            "field" => ["password"],
            "message" => "should be at least 12 character(s)"
          }
        ]
      } =
        gql_post(%{query: @register, variables: variables})
    end

    test "returns forbidden error when user is logged in" do
      user = AccountsFixtures.user_fixture()

      %{
        "data" => %{"register" => nil},
        "errors" => [%{"message" => "forbidden"}]
      } =
        gql_post(%{
          add_token_for: user,
          query: @register,
          variables: %{
            "input" => %{
              "email" => "testing@example.com",
              "password" => "zaq1@WSX1234"
            }
          }
        })
    end
  end
end
