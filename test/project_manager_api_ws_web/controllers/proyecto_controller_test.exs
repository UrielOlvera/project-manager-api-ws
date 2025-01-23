defmodule ProjectManagerApiWsWeb.ProyectoControllerTest do
  use ProjectManagerApiWsWeb.ConnCase

  import ProjectManagerApiWs.ProyectosFixtures

  alias ProjectManagerApiWs.Proyectos.Proyecto

  @create_attrs %{
    nombre: "some nombre",
    descripcion: "some descripcion",
    fecha_inicio: ~D[2025-01-22],
    fecha_fin: ~D[2025-01-22],
    estado: "some estado"
  }
  @update_attrs %{
    nombre: "some updated nombre",
    descripcion: "some updated descripcion",
    fecha_inicio: ~D[2025-01-23],
    fecha_fin: ~D[2025-01-23],
    estado: "some updated estado"
  }
  @invalid_attrs %{nombre: nil, descripcion: nil, fecha_inicio: nil, fecha_fin: nil, estado: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all proyectos", %{conn: conn} do
      conn = get(conn, ~p"/api/proyectos")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create proyecto" do
    test "renders proyecto when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/proyectos", proyecto: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/proyectos/#{id}")

      assert %{
               "id" => ^id,
               "descripcion" => "some descripcion",
               "estado" => "some estado",
               "fecha_fin" => "2025-01-22",
               "fecha_inicio" => "2025-01-22",
               "nombre" => "some nombre"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/proyectos", proyecto: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update proyecto" do
    setup [:create_proyecto]

    test "renders proyecto when data is valid", %{conn: conn, proyecto: %Proyecto{id: id} = proyecto} do
      conn = put(conn, ~p"/api/proyectos/#{proyecto}", proyecto: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/proyectos/#{id}")

      assert %{
               "id" => ^id,
               "descripcion" => "some updated descripcion",
               "estado" => "some updated estado",
               "fecha_fin" => "2025-01-23",
               "fecha_inicio" => "2025-01-23",
               "nombre" => "some updated nombre"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, proyecto: proyecto} do
      conn = put(conn, ~p"/api/proyectos/#{proyecto}", proyecto: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete proyecto" do
    setup [:create_proyecto]

    test "deletes chosen proyecto", %{conn: conn, proyecto: proyecto} do
      conn = delete(conn, ~p"/api/proyectos/#{proyecto}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/proyectos/#{proyecto}")
      end
    end
  end

  defp create_proyecto(_) do
    proyecto = proyecto_fixture()
    %{proyecto: proyecto}
  end
end
