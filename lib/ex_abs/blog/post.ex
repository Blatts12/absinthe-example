defmodule ExAbs.Blog.Post do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias ExAbs.Auth.User
  alias ExAbs.Types

  @type t() :: ExAbs.Blog.PostSpec.t()
  @type changeset() :: Types.changeset(t())

  schema "blog_posts" do
    field :title, :string

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @required_fields [:title, :user_id]

  @spec changeset(__MODULE__.t(), Types.params()) :: changeset()
  def changeset(post, attrs) do
    post
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, min: 4, max: 48)
    |> foreign_key_constraint(:user_id)
  end
end
