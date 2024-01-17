defmodule ExAbsWeb.GraphQl.ScalarTypes do
  @moduledoc false

  use ExAbsWeb.GraphQl.Schema.Type

  alias ExAbs.Auth.ImageFileUploader

  @image_extensions ~w(.jpg .jpeg .gif .png .webp)

  @desc "Represents a file type"
  scalar :file, name: "File" do
    serialize fn
      nil ->
        ""

      %{file_name: file_name} = file ->
        ext = file_name |> Path.extname() |> String.downcase()

        if Enum.member?(@image_extensions, ext) do
          ImageFileUploader.url(file)
        else
          ""
        end
    end
  end
end
