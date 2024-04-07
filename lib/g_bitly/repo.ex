defmodule GBitly.Repo do
  use Ecto.Repo,
    otp_app: :g_bitly,
    adapter: Ecto.Adapters.Postgres
end
