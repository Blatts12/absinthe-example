defmodule ExAbsWeb.GraphQl.HandleErrors do
  @moduledoc false
  @behaviour Absinthe.Middleware

  alias Ecto.Changeset

  @type absinthe_error() :: %{
          required(:message) => String.t(),
          required(:code) => atom(),
          optional(:validation) => String.t(),
          optional(:constraint) => String.t(),
          optional(:field) => [String.t()] | nil
        }

  @spec call(Absinthe.Resolution.t(), any()) :: Absinthe.Resolution.t()
  def call(resolution, _config) do
    %{
      resolution
      | errors:
          Enum.flat_map(resolution.errors, fn
            %Changeset{} = changeset -> handle_changeset(changeset)
            error -> [error]
          end)
    }
  end

  @spec handle_changeset(Changeset.t()) :: [absinthe_error()]
  defp handle_changeset(%{valid?: true}), do: []

  defp handle_changeset(changeset) do
    changeset
    |> Changeset.traverse_errors(&put_message_into_changeset_error/1)
    |> Enum.flat_map(fn {field, errors} -> format_changeset_errors([field], errors) end)
  end

  @spec format_changeset_errors([atom()], Enumerable.t()) :: [absinthe_error()]
  defp format_changeset_errors(path, errors) do
    Enum.flat_map(errors, fn
      %{message: message, validation: validation} ->
        [
          %{
            code: :validation_failed,
            message: message,
            validation: to_string(validation),
            field: Enum.reverse(path)
          }
        ]

      %{message: message, constraint: constraint} ->
        [
          %{
            code: :validation_failed,
            message: message,
            constraint: to_string(constraint),
            field: Enum.reverse(path)
          }
        ]

      # validate_change/2 with message
      {:message, message} when is_binary(message) ->
        [
          %{
            code: :validation_failed,
            message: Gettext.gettext(Ellesz.Gettext, message),
            field: Enum.reverse(path)
          }
        ]

      # error message with metadata for the purpose of gettext'ing
      %{message: message} when is_binary(message) ->
        [
          %{
            code: :validation_failed,
            message: message,
            field: Enum.reverse(path)
          }
        ]

      # Handle multiple errors
      {field, errors} when is_map(errors) or is_list(errors) ->
        format_changeset_errors([field | path], errors)

      # Nested changeset errors
      error when is_map(error) ->
        format_changeset_errors(path, error)
    end)
  end

  @spec put_message_into_changeset_error(tuple()) :: map()
  defp put_message_into_changeset_error({msg, opts}) do
    translated_message = Gettext.dgettext(ExAbsWeb.Gettext, "errors", msg, opts)
    Enum.into(opts, %{message: translated_message})
  end
end
