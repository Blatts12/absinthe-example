defmodule AppWeb.GraphQl.ScalarTypes do
  use AppWeb.GraphQl.Schema.Type
  alias App.Uploaders.ImageFile

  @image_extensions ~w(.jpg .jpeg .gif .png .webp)

  @desc "An URL to a file"
  scalar :file, name: "File" do
    serialize fn
      nil ->
        ""

      %{file_name: file_name} = file ->
        ext = file_name |> Path.extname() |> String.downcase()

        if Enum.member?(@image_extensions, ext) do
          ImageFile.url(file)
        else
          ""
        end
    end
  end
end
