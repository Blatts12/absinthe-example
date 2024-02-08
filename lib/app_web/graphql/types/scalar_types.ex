defmodule AppWeb.GraphQl.ScalarTypes do
  use AppWeb.GraphQl.Schema.Type

  @desc "Represents a custom title"
  scalar :custom_title, name: "Title" do
    serialize fn
      nil ->
        nil

      title ->
        "Custom #{title}"
    end

    parse fn
      "Custom " <> title ->
        title

      title ->
        title
    end
  end
end
