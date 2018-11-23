defmodule Mejorarse.Repo do
  use Ecto.Repo,
    otp_app: :mejorarse,
    adapter: Ecto.Adapters.Postgres
end
