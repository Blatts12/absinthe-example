defmodule ExAbsWeb.GraphQl.Authenticated do
  @moduledoc false

  @behaviour Absinthe.Middleware

  @spec call(Absinthe.Resolution.t(), term()) :: Absinthe.Resolution.t()
  def call(%{context: %{current_user: %{id: _}}} = resolution, _config) do
    resolution
  end

  def call(resolution, _config) do
    Absinthe.Resolution.put_result(resolution, {:error, :unauthenticated})
  end
end
