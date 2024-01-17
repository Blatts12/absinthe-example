defmodule ExAbs.Types do
  @moduledoc false

  alias Ecto.Association
  alias Ecto.Changeset

  @type changeset(schema_type) :: Changeset.t(schema_type)
  @type changeset() :: Changeset.t()

  @type field(schema_type) :: schema_type | Association.NotLoaded.t() | nil

  @type id() :: integer() | binary() | String.t()

  @type params() :: %{required(binary()) => term()} | %{required(atom()) => term()}

  @type preloads() :: [atom() | {atom(), atom()}]

  @type filters() :: list({atom(), any()})

  @type ecto_save_result(schema_type) :: {:ok, schema_type} | {:error, Changeset.t()}

  @type supervisor_start_link_response() ::
          {:ok, pid} | {:error, {:already_started, pid} | {:shutdown, term} | term}

  @type conn() :: Plug.Conn.t()
end
