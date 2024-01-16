defmodule ExAbsWeb.GraphQl.Auth.UserMutationsTest do
  use ExAbsWeb.GraphQlCase

  alias Absinthe.Relay.Node
  alias ExAbs.Auth
  alias ExAbs.Auth.User
  alias ExAbsWeb.GraphQl.Schema

  describe "create_user" do
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

    test "creates user when input is valid" do
      user_params = params_for(:user)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "user" => %{
                     "id" => global_id,
                     "username" => _
                   }
                 }
               }
             } =
               gql_post(%{
                 query: @create_user,
                 variables: %{"input" => user_params}
               })

      {:ok, %{id: id}} = Node.from_global_id(global_id, Schema)
      assert %User{} = Auth.get_user(id)
    end

    test "returns error when input is invalid" do
      assert %{
               "data" => %{"createUser" => nil},
               "errors" => [%{"message" => "should be at least 4 character(s)", "field" => ["username"]}]
             } =
               gql_post(%{
                 query: @create_user,
                 variables: %{"input" => %{username: "bad"}}
               })
    end
  end
end
