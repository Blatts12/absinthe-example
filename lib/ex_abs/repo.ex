defmodule ExAbs.Repo do
  use Ecto.Repo,
    otp_app: :ex_abs,
    adapter: Ecto.Adapters.Postgres

  use Paginator
end
