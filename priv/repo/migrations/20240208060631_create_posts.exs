defmodule App.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:user_id])
  end
end
