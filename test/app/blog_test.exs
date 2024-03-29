defmodule App.BlogTest do
  use App.DataCase

  alias App.Blog

  describe "posts" do
    alias App.Blog.Post

    import App.AccountsFixtures
    import App.BlogFixtures

    @invalid_attrs %{title: nil}

    test "list_posts/0 returns all posts" do
      user = user_fixture()
      post = post_fixture(%{user_id: user.id})
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      user = user_fixture()
      post = post_fixture(%{user_id: user.id})
      assert Blog.get_post!(post.id) == post
    end

    test "get_post/1 returns the post with given id" do
      user = user_fixture()
      post = post_fixture(%{user_id: user.id})
      assert Blog.get_post(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      user = user_fixture()
      valid_attrs = %{title: "some title", user_id: user.id}

      assert {:ok, %Post{} = post} = Blog.create_post(valid_attrs)
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      user = user_fixture()
      post = post_fixture(%{user_id: user.id})
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Post{} = post} = Blog.update_post(post, update_attrs)
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      user = user_fixture()
      post = post_fixture(%{user_id: user.id})
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      user = user_fixture()
      post = post_fixture(%{user_id: user.id})
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      user = user_fixture()
      post = post_fixture(%{user_id: user.id})
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
