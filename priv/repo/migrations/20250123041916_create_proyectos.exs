defmodule ProjectManagerApiWs.Repo.Migrations.CreateProyectos do
  use Ecto.Migration

  def change do
    create table(:proyectos) do
      add :nombre, :string
      add :descripcion, :string
      add :fecha_inicio, :date
      add :fecha_fin, :date
      add :estado, :string

      timestamps(type: :utc_datetime)
    end
  end
end
