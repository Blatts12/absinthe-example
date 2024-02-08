[
  import_deps: [:ecto, :ecto_sql, :phoenix, :absinthe],
  plugins: [Absinthe.Formatter],
  subdirectories: ["priv/*/migrations"],
  inputs: ["*.{ex,exs}", "{config,lib,test}/**/*.{ex,exs}", "priv/*/seeds.exs"]
]
