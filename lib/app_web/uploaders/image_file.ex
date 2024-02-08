defmodule App.Uploaders.ImageFile do
  use Waffle.Definition
  use Waffle.Ecto.Definition

  @versions [:original]
  @allowed_extensions ~w(.jpg .jpeg .gif .png .webp)

  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname() |> String.downcase()

    if Enum.member?(@allowed_extensions, file_extension) do
      :ok
    else
      {:error, Gettext.dgettext(AppWeb.Gettext, "errors", "invalid file type")}
    end
  end

  def storage_dir(_version, {_file, _scope}) do
    get_root_path() <> "/images"
  end

  def get_root_path do
    Application.get_env(:waffle, :root_path)
  end
end
