defmodule ProjectManagerApiWsWeb.ProyectoJSON do
  alias ProjectManagerApiWs.Proyectos.Proyecto

  @doc """
  Renders a list of proyectos.
  """
  def index(%{proyectos: proyectos}) do
    %{data: for(proyecto <- proyectos, do: data(proyecto))}
  end

  @doc """
  Renders a single proyecto.
  """
  def show(%{proyecto: proyecto}) do
    %{data: data(proyecto)}
  end

  defp data(%Proyecto{} = proyecto) do
    %{
      id: proyecto.id,
      nombre: proyecto.nombre,
      descripcion: proyecto.descripcion,
      fecha_inicio: proyecto.fecha_inicio,
      fecha_fin: proyecto.fecha_fin,
      estado: proyecto.estado
    }
  end
end
