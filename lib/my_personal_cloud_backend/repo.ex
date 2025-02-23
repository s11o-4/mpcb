defmodule MyPersonalCloudBackend.Repo do
  use Ecto.Repo,
    otp_app: :my_personal_cloud_backend,
    adapter: Ecto.Adapters.Postgres
end
