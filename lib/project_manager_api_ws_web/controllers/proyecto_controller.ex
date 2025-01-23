defmodule ProjectManagerApiWsWeb.ProyectoController do
  use ProjectManagerApiWsWeb, :controller

  alias ProjectManagerApiWs.Proyectos
  alias ProjectManagerApiWs.Proyectos.Proyecto

  action_fallback ProjectManagerApiWsWeb.FallbackController

  def index(conn, _params) do
    proyectos = Proyectos.list_proyectos()
    render(conn, :index, proyectos: proyectos)
  end

  def create(conn, %{"proyecto" => proyecto_params}) do
    with {:ok, %Proyecto{} = proyecto} <- Proyectos.create_proyecto(proyecto_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/proyectos/#{proyecto}")
      |> render(:show, proyecto: proyecto)
    end
  end

  def show(conn, %{"id" => id}) do
    proyecto = Proyectos.get_proyecto!(id)
    render(conn, :show, proyecto: proyecto)
  end

  def update(conn, %{"id" => id, "proyecto" => proyecto_params}) do
    proyecto = Proyectos.get_proyecto!(id)

    with {:ok, %Proyecto{} = proyecto} <- Proyectos.update_proyecto(proyecto, proyecto_params) do
      render(conn, :show, proyecto: proyecto)
    end
  end

  def delete(conn, %{"id" => id}) do
    proyecto = Proyectos.get_proyecto!(id)

    with {:ok, %Proyecto{}} <- Proyectos.delete_proyecto(proyecto) do
      send_resp(conn, :no_content, "")
    end
  end
end
