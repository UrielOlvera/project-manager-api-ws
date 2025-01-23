defmodule ProjectManagerApiWs.Proyectos.Proyecto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "proyectos" do
    field :nombre, :string
    field :descripcion, :string
    field :fecha_inicio, :date
    field :fecha_fin, :date
    field :estado, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(proyecto, attrs) do
    proyecto
    |> cast(attrs, [:nombre, :descripcion, :fecha_inicio, :fecha_fin, :estado])
    |> validate_required([:nombre, :descripcion, :fecha_inicio, :fecha_fin, :estado])
  end
end
