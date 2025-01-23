defmodule ProjectManagerApiWsWeb.UsuarioJSON do
  alias ProjectManagerApiWs.Usuarios.Usuario

  @doc """
  Renders a list of usuarios.
  """
  def index(%{usuarios: usuarios}) do
    %{data: for(usuario <- usuarios, do: data(usuario))}
  end

  @doc """
  Renders a single usuario.
  """
  def show(%{usuario: usuario}) do
    %{data: data(usuario)}
  end

  defp data(%Usuario{} = usuario) do
    %{
      id: usuario.id,
      nombre: usuario.nombre,
      correo: usuario.correo,
      contrasena_hash: usuario.contrasena_hash,
      rol: usuario.rol
    }
  end
end
