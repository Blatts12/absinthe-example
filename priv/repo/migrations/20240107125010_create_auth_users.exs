defmodule ExAbs.Repo.Migrations.CreateAuthUsers do
  use Ecto.Migration

  def change do
    create table(:auth_users) do
      add :username, :string

      timestamps(type: :utc_datetime)
    end
  end
end
