defmodule ProjectManagerApiWs.UsuariosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProjectManagerApiWs.Usuarios` context.
  """

  @doc """
  Generate a unique usuario correo.
  """
  def unique_usuario_correo, do: "some correo#{System.unique_integer([:positive])}"

  @doc """
  Generate a usuario.
  """
  def usuario_fixture(attrs \\ %{}) do
    {:ok, usuario} =
      attrs
      |> Enum.into(%{
        contrasena_hash: "some contrasena_hash",
        correo: unique_usuario_correo(),
        nombre: "some nombre",
        rol: "some rol"
      })
      |> ProjectManagerApiWs.Usuarios.create_usuario()

    usuario
  end
end
