defmodule ExAbs.Repo.Migrations.AddAvatarFieldToAuthUsers do
  use Ecto.Migration

  def change do
    alter table(:auth_users) do
      add :avatar, :string, null: true
    end
  end
end
