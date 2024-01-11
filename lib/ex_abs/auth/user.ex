defmodule ExAbs.Auth.User do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias ExAbs.Types

  @type t() :: ExAbs.Auth.UserSpec.t()
  @type changeset() :: Types.changeset(t())

  schema "auth_users" do
    field :username, :string

    timestamps(type: :utc_datetime)
  end

  @required_fields [:username]

  @spec changeset(t() | changeset(), Types.params()) :: changeset()
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_username()
  end

  @spec validate_username(changeset()) :: changeset()
  defp validate_username(changeset) do
    validate_length(changeset, :username, min: 4, max: 48)
  end
end
