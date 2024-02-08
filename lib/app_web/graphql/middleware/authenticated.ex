defmodule AppWeb.GraphQl.Middleware.Authenticated do
  @behaviour Absinthe.Middleware

  def call(%{context: %{current_user: %{id: _}}} = resolution, _config) do
    resolution
  end

  def call(resolution, _config) do
    Absinthe.Resolution.put_result(resolution, {:error, :unauthorized})
  end
end
