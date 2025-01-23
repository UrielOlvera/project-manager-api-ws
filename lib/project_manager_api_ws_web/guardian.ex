defmodule ProjectManagerApiWs.Guardian do
  use Guardian, otp_app: :project_manager_api_ws

  alias ProjectManagerApiWs.Usuarios
  alias ProjectManagerApiWs.Usuarios.Usuario

  @impl true
  def subject_for_token(%Usuario{id: id}, _claims) do
    {:ok, to_string(id)}
  end

  @impl true
  def subject_for_token(_, _) do
    {:error, :invalid_subject}
  end

  @impl true
  def resource_from_claims(%{"sub" => id}) do
    case Usuarios.get_usuario!(id) do
      nil -> {:error, :resource_not_found}
      usuario -> {:ok, usuario}
    end
  end

  @impl true
  def resource_from_claims(_claims) do
    {:error, :invalid_claims}
  end
end
