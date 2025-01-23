defmodule ProjectManagerApiWs.ProyectosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProjectManagerApiWs.Proyectos` context.
  """

  @doc """
  Generate a proyecto.
  """
  def proyecto_fixture(attrs \\ %{}) do
    {:ok, proyecto} =
      attrs
      |> Enum.into(%{
        descripcion: "some descripcion",
        estado: "some estado",
        fecha_fin: ~D[2025-01-22],
        fecha_inicio: ~D[2025-01-22],
        nombre: "some nombre"
      })
      |> ProjectManagerApiWs.Proyectos.create_proyecto()

    proyecto
  end
end
