use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :othello, OthelloWeb.Endpoint,
  secret_key_base: "uZIVQhW+GC2Jv3a+msFnLvu/Ozm3QqBKmCo5CCkwcfgkymSzO6pQPFkGrD7A5rF/"

# Configure your database
config :othello, Othello.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "othello_prod",
  pool_size: 15
