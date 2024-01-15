defmodule ExAbs.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts) do
      add :title, :string
      add :user_id, references(:auth_users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
