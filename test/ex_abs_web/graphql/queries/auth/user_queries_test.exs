defmodule ExAbsWeb.GraphQl.Auth.UserQueriesTest do
  use ExAbsWeb.ConnCase

  describe "get_user" do
    @get_user """
    query getUser($id: ID!) {
      getUser(id: $id) {
        id
        username
      }
    }
    """

    test "returns user when found", %{conn: conn} do
      user = insert(:user)

      conn =
        post(conn, "/api/graphql", %{
          "query" => @get_user,
          "variables" => %{"id" => user.id}
        })

      assert %{
               "data" => %{
                 "getUser" => %{
                   "id" => to_string(user.id),
                   "username" => user.username
                 }
               }
             } == json_response(conn, 200)
    end

    test "returns 'not_found' error when missing", %{conn: conn} do
      conn =
        post(conn, "/api/graphql", %{
          "query" => @get_user,
          "variables" => %{"id" => -1}
        })

      assert %{
               "data" => %{"getUser" => nil},
               "errors" => [%{"message" => "not_found"}]
             } = json_response(conn, 200)
    end
  end

  describe "list_users" do
    @list_users """
    query listUsers {
      listUsers {
        id
        username
      }
    }
    """

    test "returns list of users when available", %{conn: conn} do
      user = insert(:user)
      conn = post(conn, "/api/graphql", %{"query" => @list_users})

      assert %{
               "data" => %{
                 "listUsers" => [
                   %{
                     "id" => to_string(user.id),
                     "username" => user.username
                   }
                 ]
               }
             } == json_response(conn, 200)
    end

    test "returns empty list when missing", %{conn: conn} do
      conn = post(conn, "/api/graphql", %{"query" => @list_users})
      assert %{"data" => %{"listUsers" => []}} = json_response(conn, 200)
    end
  end
end
