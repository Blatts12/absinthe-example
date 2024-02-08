defmodule AppWeb.GraphQl.Middleware.HandleChangesetErrors do
  alias Ecto.Changeset

  @behaviour Absinthe.Middleware

  def call(resolution, _opts) do
    %{
      resolution
      | errors:
          Enum.flat_map(resolution.errors, fn
            %Changeset{} = changeset -> handle_changeset(changeset)
            error -> [error]
          end)
    }
  end

  defp handle_changeset(%{valid?: true}), do: []

  defp handle_changeset(changeset) do
    changeset
    |> Changeset.traverse_errors(&put_message_into_changeset_error/1)
    |> Enum.flat_map(fn {field, errors} ->
      format_changeset_errors([field], errors)
    end)
  end

  defp format_changeset_errors(path, errors) do
    Enum.flat_map(errors, fn
      %{message: message, validation: validation} ->
        [
          %{
            message: message,
            details: %{
              code: :validation_failed,
              validation: to_string(validation),
              field: Enum.reverse(path)
            }
          }
        ]

      %{message: message, constraint: constraint} ->
        [
          %{
            message: message,
            details: %{
              code: :validation_failed,
              constraint: to_string(constraint),
              field: Enum.reverse(path)
            }
          }
        ]

      # validate_change/2 with message
      {:message, message} when is_binary(message) ->
        [
          %{
            message: Gettext.gettext(AppWeb.Gettext, message),
            details: %{
              code: :validation_failed,
              field: Enum.reverse(path)
            }
          }
        ]

      %{message: message} when is_binary(message) ->
        [
          %{
            message: message,
            details: %{
              code: :validation_failed,
              field: Enum.reverse(path)
            }
          }
        ]

      # Handle multiple errors
      {field, errors} when is_map(errors) or is_list(errors) ->
        format_changeset_errors([field | path], errors)

      # Handle nested changeset errors
      error when is_map(error) ->
        format_changeset_errors(path, error)
    end)
  end

  defp put_message_into_changeset_error({msg, opts}) do
    translated_message = Gettext.dgettext(AppWeb.Gettext, "errors", msg, opts)
    Enum.into(opts, %{message: translated_message})
  end
end
