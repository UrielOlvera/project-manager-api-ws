defmodule ProjectManagerApiWs.Repo.Migrations.CreateUsuarios do
  use Ecto.Migration

  def change do
    create table(:usuarios) do
      add :nombre, :string
      add :correo, :string
      add :contrasena_hash, :string
      add :rol, :string, default: "Colaborador"

      timestamps(type: :utc_datetime)
    end

    create unique_index(:usuarios, [:correo])
  end
end
