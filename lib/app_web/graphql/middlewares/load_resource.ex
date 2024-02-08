defmodule AppWeb.GraphQl.Middleware.LoadResource do
  @behaviour Absinthe.Middleware

  def call(%{state: :resolved} = resolution, _config), do: resolution

  def call(%{arguments: arguments, context: context} = resolution, config) do
    getter = config[:getter] || raise ArgumentError, ":getter is required"
    id_path = config[:id_path] || [:id]
    resource_key = config[:resource_key] || :resource

    id = get_in(arguments, id_path)

    getter_result =
      try do
        getter.(id)
      rescue
        e in Ecto.NoResultsError -> e
      end

    case getter_result do
      nil ->
        Absinthe.Resolution.put_result(resolution, {:error, :not_found})

      %Ecto.NoResultsError{} ->
        Absinthe.Resolution.put_result(resolution, {:error, :not_found})

      resource ->
        %{
          resolution
          | context: Map.put(context, resource_key, resource)
        }
    end
  end

  def call(resolution, _config), do: resolution
end
