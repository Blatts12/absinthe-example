defmodule AppWeb.GraphQl.Middleware.AuthorizeResource do
  @behaviour Absinthe.Middleware

  alias App.Accounts.User

  def call(%{state: :resolved} = resolution, _config), do: resolution

  def call(%{context: context} = resolution, config) do
    resource_key = config[:resource_key] || :resource
    auth_type = config[:type] || :owner
    auth_fn = config[:auth_fn] || (&authorize/3)

    resource = Map.get(context, resource_key)
    user = Map.get(context, :current_user)

    if run_auth(auth_fn, user, resource, auth_type) do
      resolution
    else
      Absinthe.Resolution.put_result(resolution, {:error, :unauthorized})
    end
  end

  def call(resolution, _config), do: resolution

  defp run_auth(auth_fn, user, resource, _type) when is_function(auth_fn, 2) do
    auth_fn.(user, resource)
  end

  defp run_auth(auth_fn, user, resource, type) when is_function(auth_fn, 3) do
    auth_fn.(user, resource, type)
  end

  defp run_auth(_auth_fn, _user, _resource, _type) do
    raise "Invalid authorization function"
  end

  defp authorize(%User{id: user_id}, %{user_id: user_id}, :owner), do: true

  defp authorize(%User{id: user_id}, %User{id: user_id}, :owner), do: true

  defp authorize(_, _, _), do: false
end
