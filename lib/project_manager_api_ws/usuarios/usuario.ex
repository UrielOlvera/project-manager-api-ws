defmodule ProjectManagerApiWs.Usuarios.Usuario do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :nombre, :correo, :rol]}
  schema "usuarios" do
    field :nombre, :string
    field :correo, :string
    field :contrasena_hash, :string
    field :rol, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(usuario, attrs) do
    usuario
    |> cast(attrs, [:nombre, :correo, :contrasena_hash, :rol])
    |> validate_required([:nombre, :correo, :contrasena_hash, :rol])
    |> unique_constraint(:correo)
    |> validate_length(:contrasena_hash, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    if password = get_change(changeset, :contrasena_hash) do
      change(changeset, contrasena_hash: Argon2.hash_pwd_salt(password))
    else
      changeset
    end
  end
end
