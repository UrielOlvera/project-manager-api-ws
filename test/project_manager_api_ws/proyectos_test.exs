defmodule ProjectManagerApiWs.ProyectosTest do
  use ProjectManagerApiWs.DataCase

  alias ProjectManagerApiWs.Proyectos

  describe "proyectos" do
    alias ProjectManagerApiWs.Proyectos.Proyecto

    import ProjectManagerApiWs.ProyectosFixtures

    @invalid_attrs %{nombre: nil, descripcion: nil, fecha_inicio: nil, fecha_fin: nil, estado: nil}

    test "list_proyectos/0 returns all proyectos" do
      proyecto = proyecto_fixture()
      assert Proyectos.list_proyectos() == [proyecto]
    end

    test "get_proyecto!/1 returns the proyecto with given id" do
      proyecto = proyecto_fixture()
      assert Proyectos.get_proyecto!(proyecto.id) == proyecto
    end

    test "create_proyecto/1 with valid data creates a proyecto" do
      valid_attrs = %{nombre: "some nombre", descripcion: "some descripcion", fecha_inicio: ~D[2025-01-22], fecha_fin: ~D[2025-01-22], estado: "some estado"}

      assert {:ok, %Proyecto{} = proyecto} = Proyectos.create_proyecto(valid_attrs)
      assert proyecto.nombre == "some nombre"
      assert proyecto.descripcion == "some descripcion"
      assert proyecto.fecha_inicio == ~D[2025-01-22]
      assert proyecto.fecha_fin == ~D[2025-01-22]
      assert proyecto.estado == "some estado"
    end

    test "create_proyecto/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Proyectos.create_proyecto(@invalid_attrs)
    end

    test "update_proyecto/2 with valid data updates the proyecto" do
      proyecto = proyecto_fixture()
      update_attrs = %{nombre: "some updated nombre", descripcion: "some updated descripcion", fecha_inicio: ~D[2025-01-23], fecha_fin: ~D[2025-01-23], estado: "some updated estado"}

      assert {:ok, %Proyecto{} = proyecto} = Proyectos.update_proyecto(proyecto, update_attrs)
      assert proyecto.nombre == "some updated nombre"
      assert proyecto.descripcion == "some updated descripcion"
      assert proyecto.fecha_inicio == ~D[2025-01-23]
      assert proyecto.fecha_fin == ~D[2025-01-23]
      assert proyecto.estado == "some updated estado"
    end

    test "update_proyecto/2 with invalid data returns error changeset" do
      proyecto = proyecto_fixture()
      assert {:error, %Ecto.Changeset{}} = Proyectos.update_proyecto(proyecto, @invalid_attrs)
      assert proyecto == Proyectos.get_proyecto!(proyecto.id)
    end

    test "delete_proyecto/1 deletes the proyecto" do
      proyecto = proyecto_fixture()
      assert {:ok, %Proyecto{}} = Proyectos.delete_proyecto(proyecto)
      assert_raise Ecto.NoResultsError, fn -> Proyectos.get_proyecto!(proyecto.id) end
    end

    test "change_proyecto/1 returns a proyecto changeset" do
      proyecto = proyecto_fixture()
      assert %Ecto.Changeset{} = Proyectos.change_proyecto(proyecto)
    end
  end
end
