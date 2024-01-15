defmodule ExAbsWeb.GraphQl.Auth.UserMutationsTest do
  use ExAbsWeb.GraphQlCase

  alias ExAbs.Auth
  alias ExAbs.Auth.User

  describe "create_user" do
    @create_user """
    mutation createUser($input: CreateUserInput!) {
      createUser(input: $input) {
        id
        username
      }
    }
    """

    test "creates user when input is valid" do
      user_params = params_for(:user)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "id" => id,
                   "username" => _
                 }
               }
             } =
               gql_post(%{
                 "query" => @create_user,
                 "variables" => %{"input" => user_params}
               })

      assert %User{} = Auth.get_user(id)
    end

    test "returns error when input is invalid" do
      assert %{
               "data" => %{"createUser" => nil},
               "errors" => [%{"message" => "should be at least 4 character(s)", "field" => ["username"]}]
             } =
               gql_post(%{
                 "query" => @create_user,
                 "variables" => %{"input" => %{username: "bad"}}
               })
    end
  end
end
