defmodule ProjectManagerApiWs.Repo do
  use Ecto.Repo,
    otp_app: :project_manager_api_ws,
    adapter: Ecto.Adapters.Tds
end
