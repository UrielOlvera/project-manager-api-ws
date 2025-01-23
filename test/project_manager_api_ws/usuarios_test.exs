defmodule ProjectManagerApiWs.UsuariosTest do
  use ProjectManagerApiWs.DataCase

  alias ProjectManagerApiWs.Usuarios

  describe "usuarios" do
    alias ProjectManagerApiWs.Usuarios.Usuario

    import ProjectManagerApiWs.UsuariosFixtures

    @invalid_attrs %{nombre: nil, correo: nil, contrasena_hash: nil, rol: nil}

    test "list_usuarios/0 returns all usuarios" do
      usuario = usuario_fixture()
      assert Usuarios.list_usuarios() == [usuario]
    end

    test "get_usuario!/1 returns the usuario with given id" do
      usuario = usuario_fixture()
      assert Usuarios.get_usuario!(usuario.id) == usuario
    end

    test "create_usuario/1 with valid data creates a usuario" do
      valid_attrs = %{nombre: "some nombre", correo: "some correo", contrasena_hash: "some contrasena_hash", rol: "some rol"}

      assert {:ok, %Usuario{} = usuario} = Usuarios.create_usuario(valid_attrs)
      assert usuario.nombre == "some nombre"
      assert usuario.correo == "some correo"
      assert usuario.contrasena_hash == "some contrasena_hash"
      assert usuario.rol == "some rol"
    end

    test "create_usuario/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Usuarios.create_usuario(@invalid_attrs)
    end

    test "update_usuario/2 with valid data updates the usuario" do
      usuario = usuario_fixture()
      update_attrs = %{nombre: "some updated nombre", correo: "some updated correo", contrasena_hash: "some updated contrasena_hash", rol: "some updated rol"}

      assert {:ok, %Usuario{} = usuario} = Usuarios.update_usuario(usuario, update_attrs)
      assert usuario.nombre == "some updated nombre"
      assert usuario.correo == "some updated correo"
      assert usuario.contrasena_hash == "some updated contrasena_hash"
      assert usuario.rol == "some updated rol"
    end

    test "update_usuario/2 with invalid data returns error changeset" do
      usuario = usuario_fixture()
      assert {:error, %Ecto.Changeset{}} = Usuarios.update_usuario(usuario, @invalid_attrs)
      assert usuario == Usuarios.get_usuario!(usuario.id)
    end

    test "delete_usuario/1 deletes the usuario" do
      usuario = usuario_fixture()
      assert {:ok, %Usuario{}} = Usuarios.delete_usuario(usuario)
      assert_raise Ecto.NoResultsError, fn -> Usuarios.get_usuario!(usuario.id) end
    end

    test "change_usuario/1 returns a usuario changeset" do
      usuario = usuario_fixture()
      assert %Ecto.Changeset{} = Usuarios.change_usuario(usuario)
    end
  end
end
