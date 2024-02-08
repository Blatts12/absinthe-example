defmodule App.Blog.Post do
  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset
  alias App.Uploaders.ImageFile

  schema "posts" do
    field :title, :string
    field :image, ImageFile.Type

    belongs_to :user, App.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :user_id])
    |> cast_attachments(attrs, [:image], allow_urls: true)
    |> validate_required([:title, :user_id])
    |> validate_length(:title, min: 4)
    |> foreign_key_constraint(:user_id)
  end
end
