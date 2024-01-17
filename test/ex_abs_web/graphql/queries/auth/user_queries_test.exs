defmodule ExAbsWeb.GraphQl.Auth.UserQueriesTest do
  use ExAbsWeb.GraphQlCase

  alias Absinthe.Relay.Node
  alias ExAbsWeb.GraphQl.Schema

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
      global_id = Node.to_global_id("User", user.id)

      assert %{
               "data" => %{
                 "getUser" => %{
                   "id" => global_id,
                   "username" => user.username
                 }
               }
             } ==
               gql_post(%{
                 query: @get_user,
                 variables: %{"id" => global_id}
               })
    end

    test "returns 'not_found' error when missing" do
      global_id = Node.to_global_id("User", -1)

      assert %{
               "data" => %{"getUser" => nil},
               "errors" => [%{"message" => "not_found"}]
             } =
               gql_post(%{
                 query: @get_user,
                 variables: %{"id" => global_id}
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
                     "id" => global_id,
                     "username" => _
                   }
                 ]
               }
             } = gql_post(%{query: @list_users})

      {:ok, %{id: id, type: :user}} = Node.from_global_id(global_id, Schema)
      assert id == to_string(user.id)
    end

    test "returns empty list when missing" do
      assert %{"data" => %{"listUsers" => []}} = gql_post(%{query: @list_users})
    end
  end

  describe "paginate_users" do
    @paginate_users """
    query paginateUsers($first: Int, $last: Int, $before: String, $after: String) {
      paginateUsers(first: $first, last: $last, before: $before, after: $after) {
        edges {
          node {
            id
            username
          }
        }
        pageInfo {
          endCursor
          startCursor
          hasNextPage
          hasPreviousPage
        }
      }
    }
    """

    test "returns paginated list of users when available" do
      insert_list(3, :user)

      assert %{
               "data" => %{
                 "paginateUsers" => %{
                   "edges" => users,
                   "pageInfo" => %{
                     "endCursor" => end_cursor,
                     "hasNextPage" => true,
                     "hasPreviousPage" => false
                   }
                 }
               }
             } =
               gql_post(%{
                 query: @paginate_users,
                 variables: %{"first" => 2}
               })

      assert Enum.count(users) == 2

      assert %{
               "data" => %{
                 "paginateUsers" => %{
                   "edges" => users,
                   "pageInfo" => %{
                     "endCursor" => _end_cursor,
                     "hasNextPage" => false,
                     "hasPreviousPage" => true
                   }
                 }
               }
             } =
               gql_post(%{
                 query: @paginate_users,
                 variables: %{"first" => 2, "after" => end_cursor}
               })

      assert Enum.count(users) == 1
    end
  end
end
