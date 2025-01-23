defmodule ProjectManagerApiWsWeb.UsuarioController do
  use ProjectManagerApiWsWeb, :controller

  alias ProjectManagerApiWs.Usuarios
  alias ProjectManagerApiWs.Usuarios.Usuario

  action_fallback ProjectManagerApiWsWeb.FallbackController

  def index(conn, _params) do
    usuarios = Usuarios.list_usuarios()
    render(conn, :index, usuarios: usuarios)
  end

  def create(conn, %{"usuario" => usuario_params}) do
    with {:ok, %Usuario{} = usuario} <- Usuarios.create_usuario(usuario_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/usuarios/#{usuario}")
      |> render(:show, usuario: usuario)
    end
  end

  def show(conn, %{"id" => id}) do
    usuario = Usuarios.get_usuario!(id)
    render(conn, :show, usuario: usuario)
  end

  def update(conn, %{"id" => id, "usuario" => usuario_params}) do
    usuario = Usuarios.get_usuario!(id)

    with {:ok, %Usuario{} = usuario} <- Usuarios.update_usuario(usuario, usuario_params) do
      render(conn, :show, usuario: usuario)
    end
  end

  def delete(conn, %{"id" => id}) do
    usuario = Usuarios.get_usuario!(id)

    with {:ok, %Usuario{}} <- Usuarios.delete_usuario(usuario) do
      send_resp(conn, :no_content, "")
    end
  end
end
