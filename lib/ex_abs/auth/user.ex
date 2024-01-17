defmodule ExAbs.Auth.User do
  @moduledoc false

  use Ecto.Schema
  use Waffle.Ecto.Schema

  import Ecto.Changeset

  alias ExAbs.Auth.ImageFileUploader
  alias ExAbs.Blog.Post
  alias ExAbs.Types

  @type t() :: ExAbs.Auth.UserSpec.t()
  @type changeset() :: Types.changeset(__MODULE__.t())

  schema "auth_users" do
    field :username, :string
    field :avatar, ImageFileUploader.Type

    has_many :posts, Post

    timestamps(type: :utc_datetime)
  end

  @required_fields [:username]

  @spec changeset(__MODULE__.t(), Types.params()) :: changeset()
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> cast_attachments(attrs, [:avatar], allow_urls: true)
    |> validate_required(@required_fields)
    |> validate_length(:username, min: 4, max: 48)
  end
end
