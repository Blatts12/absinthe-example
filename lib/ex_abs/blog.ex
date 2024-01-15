defmodule ExAbs.Blog do
  @moduledoc false

  import Contexted.Delegator

  alias ExAbs.Blog.Posts

  delegate_all(Posts)
end
