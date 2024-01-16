defmodule ExAbsWeb.GraphQl.Blog.PostTypes do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbs.Auth.User

  object :post do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :user_id, non_null(:id)
    field :user, non_null(:user), resolve: dataloader(User)
  end

  input_object :create_post_input do
    field :title, non_null(:string)
    field :user_id, non_null(:id)
  end
end
