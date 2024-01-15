defmodule ExAbsWeb.GraphQl.Auth.UserMutationsTest do
  use ExAbsWeb.ConnCase

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

    test "creates user when input is valid", %{conn: conn} do
      %{username: username} = user_params = params_for(:user)

      conn =
        post(conn, "/api/graphql", %{
          "query" => @create_user,
          "variables" => %{"input" => user_params}
        })

      assert %{
               "data" => %{
                 "createUser" => %{
                   "id" => id,
                   "username" => ^username
                 }
               }
             } = json_response(conn, 200)

      assert %User{} = Auth.get_user(id)
    end

    test "returns error when input is invalid", %{conn: conn} do
      conn =
        post(conn, "/api/graphql", %{
          "query" => @create_user,
          "variables" => %{"input" => %{username: "bad"}}
        })

      assert %{
               "data" => %{"createUser" => nil},
               "errors" => [%{"message" => "should be at least 4 character(s)", "field" => ["username"]}]
             } = json_response(conn, 200)
    end
  end
end
