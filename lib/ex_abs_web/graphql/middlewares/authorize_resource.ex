defmodule ExAbsWeb.GraphQl.AuthorizeResource do
  @moduledoc false

  @behaviour Absinthe.Middleware

  alias ExAbs.Accounts.User

  @spec call(Absinthe.Resolution.t(), Keyword.t()) :: Absinthe.Resolution.t()
  def call(%{state: :resolved} = resolution, _config), do: resolution

  def call(%{context: context} = resolution, config) do
    resource_key = config[:resource_key] || :resource
    auth_type = config[:type] || :owner

    resource = Map.get(context, resource_key)
    user = Map.get(context, :current_user)

    if authorize(resource, user, auth_type) do
      resolution
    else
      Absinthe.Resolution.put_result(resolution, {:error, :unauthorized})
    end
  end

  def call(resolution, _config), do: resolution

  @spec authorize(any(), User.t(), atom()) :: boolean()
  defp authorize(%{user_id: user_id}, %User{id: user_id}, :owner), do: true

  defp authorize(%User{id: user_id}, %User{id: user_id}, :owner), do: true

  defp authorize(_, _, _), do: false
end
