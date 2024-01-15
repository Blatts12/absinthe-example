defmodule ExAbs.Repo.Migrations.CreateCursorPaginationIndexForAuthUsers do
  use Ecto.Migration

  def change do
    create index(:auth_users, [:inserted_at, :id])
  end
end
