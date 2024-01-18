defmodule ExAbsWeb.GraphQl.Unauthenticated do
  @moduledoc false

  @behaviour Absinthe.Middleware

  @spec call(Absinthe.Resolution.t(), any()) :: Absinthe.Resolution.t()
  def call(%{context: %{current_user: %{id: _}}} = resolution, _config) do
    Absinthe.Resolution.put_result(resolution, {:error, :forbidden})
  end

  def call(resolution, _config) do
    resolution
  end
end
