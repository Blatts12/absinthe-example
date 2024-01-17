defmodule ExAbs.Auth.UsersTest do
  use ExAbs.DataCase

  alias ExAbs.Auth
  alias ExAbs.Auth.User

  describe "list_users/0" do
    test "returns all users" do
      user = insert(:user)
      assert Auth.list_users() == [user]
    end
  end

  describe "paginate_users/1" do
    test "returns 2 users per page" do
      insert_list(5, :user)
      params = %{first: 2}

      {:ok, %{edges: edges, page_info: page_info}} = Auth.paginate_users(params)
      assert Enum.count(edges) == 2

      params = %{first: 2, after: page_info.end_cursor}
      {:ok, %{edges: edges, page_info: page_info}} = Auth.paginate_users(params)
      assert Enum.count(edges) == 2

      params = %{first: 2, after: page_info.end_cursor}
      {:ok, %{edges: edges, page_info: page_info}} = Auth.paginate_users(params)
      assert Enum.count(edges) == 1

      params = %{last: 2, before: page_info.start_cursor}
      {:ok, %{edges: edges}} = Auth.paginate_users(params)
      assert Enum.count(edges) == 2
    end
  end

  describe "get_user!/1" do
    test "returns the user with given id" do
      user = insert(:user)
      assert Auth.get_user!(user.id) == user
    end

    test "raises error with nonexistent id" do
      assert_raise(Ecto.NoResultsError, fn ->
        Auth.get_user!(-1)
      end)
    end
  end

  describe "get_user/1" do
    test "returns the user with given id" do
      user = insert(:user)
      assert Auth.get_user(user.id) == user
    end

    test "returns nil with nonexistent id" do
      assert is_nil(Auth.get_user(-1))
    end
  end

  describe "create_user/1" do
    test "with valid data creates a user" do
      valid_attrs = params_for(:user)
      assert {:ok, %User{}} = Auth.create_user(valid_attrs)
    end

    test "with invalid data returns error changeset" do
      invalid_attrs = params_for(:user, username: "bad")
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(invalid_attrs)
    end
  end

  describe "update_user/2" do
    test "with valid data updates the user" do
      user = insert(:user)
      update_attrs = params_for(:user)
      assert {:ok, %User{}} = Auth.update_user(user, update_attrs)
    end

    test "with invalid data returns error changeset" do
      user = insert(:user)
      invalid_attrs = params_for(:user, username: "bad")

      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, invalid_attrs)
      assert user == Auth.get_user!(user.id)
    end
  end

  describe "delete_user/1" do
    test "deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Auth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user!(user.id) end
    end
  end

  describe "change_user/2" do
    test "returns a user changeset" do
      user = insert(:user)
      valid_attrs = params_for(:user)

      assert %Ecto.Changeset{} = Auth.change_user(user, valid_attrs)
    end
  end
end
