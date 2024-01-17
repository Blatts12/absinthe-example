defmodule ExAbs.Auth.ImageFileUploader do
  @moduledoc false

  use Waffle.Definition
  use Waffle.Ecto.Definition

  @versions [:original]
  @allowed_extensions ~w(.jpg .jpeg .gif .png .webp)

  @spec validate({Waffle.File.t(), map()}) :: :ok | {:error, String.t()}
  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname() |> String.downcase()

    if Enum.member?(@allowed_extensions, file_extension) do
      :ok
    else
      {:error, Gettext.dgettext(ExAbsWeb.Gettext, "errors", "invalid file type")}
    end
  end

  # Override the storage directory:
  @spec storage_dir(atom(), {Waffle.File.t(), map()}) :: String.t()
  def storage_dir(_version, {_file, _scope}) do
    get_root_path() <> "/images"
  end

  @spec get_root_path :: String.t()
  def get_root_path do
    Application.get_env(:waffle, :root_path)
  end
end
