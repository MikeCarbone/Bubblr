defmodule Newsfun.Repo do
  use Ecto.Repo,
    otp_app: :newsfun,
    adapter: Ecto.Adapters.Postgres
end
