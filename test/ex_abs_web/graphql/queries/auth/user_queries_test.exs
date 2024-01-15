defmodule ExAbsWeb.GraphQl.Auth.UserQueriesTest do
  use ExAbsWeb.GraphQlCase

  describe "get_user" do
    @get_user """
    query getUser($id: ID!) {
      getUser(id: $id) {
        id
        username
      }
    }
    """

    test "returns user when found" do
      user = insert(:user)

      assert %{
               "data" => %{
                 "getUser" => %{
                   "id" => to_string(user.id),
                   "username" => user.username
                 }
               }
             } ==
               gql_post(%{
                 "query" => @get_user,
                 "variables" => %{"id" => user.id}
               })
    end

    test "returns 'not_found' error when missing" do
      assert %{
               "data" => %{"getUser" => nil},
               "errors" => [%{"message" => "not_found"}]
             } =
               gql_post(%{
                 "query" => @get_user,
                 "variables" => %{"id" => -1}
               })
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

    test "returns list of users when available" do
      user = insert(:user)

      assert %{
               "data" => %{
                 "listUsers" => [
                   %{
                     "id" => to_string(user.id),
                     "username" => user.username
                   }
                 ]
               }
             } == gql_post(%{"query" => @list_users})
    end

    test "returns empty list when missing" do
      assert %{"data" => %{"listUsers" => []}} = gql_post(%{"query" => @list_users})
    end
  end
end
