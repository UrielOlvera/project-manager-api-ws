defmodule ProjectManagerApiWs.Usuarios do
  @moduledoc """
  The Usuarios context.
  """

  import Ecto.Query, warn: false
  alias ProjectManagerApiWs.Repo

  alias ProjectManagerApiWs.Usuarios.Usuario
  alias ProjectManagerApiWs.Repo
  alias ProjectManagerApiWs.Guardian

  @doc """
  Returns the list of usuarios.

  ## Examples

      iex> list_usuarios()
      [%Usuario{}, ...]

  """
  def list_usuarios do
    Repo.all(Usuario)
  end

  @doc """
  Gets a single usuario.

  Raises `Ecto.NoResultsError` if the Usuario does not exist.

  ## Examples

      iex> get_usuario!(123)
      %Usuario{}

      iex> get_usuario!(456)
      ** (Ecto.NoResultsError)

  """
  def get_usuario!(id), do: Repo.get!(Usuario, id)

  @doc """
  Creates a usuario.

  ## Examples

      iex> create_usuario(%{field: value})
      {:ok, %Usuario{}}

      iex> create_usuario(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_usuario(attrs \\ %{}) do
    %Usuario{}
    |> Usuario.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a usuario.

  ## Examples

      iex> update_usuario(usuario, %{field: new_value})
      {:ok, %Usuario{}}

      iex> update_usuario(usuario, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_usuario(%Usuario{} = usuario, attrs) do
    usuario
    |> Usuario.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a usuario.

  ## Examples

      iex> delete_usuario(usuario)
      {:ok, %Usuario{}}

      iex> delete_usuario(usuario)
      {:error, %Ecto.Changeset{}}

  """
  def delete_usuario(%Usuario{} = usuario) do
    Repo.delete(usuario)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking usuario changes.

  ## Examples

      iex> change_usuario(usuario)
      %Ecto.Changeset{data: %Usuario{}}

  """
  def change_usuario(%Usuario{} = usuario, attrs \\ %{}) do
    Usuario.changeset(usuario, attrs)
  end

  def authenticate(correo, contrasena) do
    usuario = Repo.get_by(Usuario, correo: correo)

    cond do
      usuario && Argon2.verify_pass(contrasena, usuario.contrasena_hash) ->
        {:ok, usuario}

      true ->
        {:error, :unauthorized}
    end
  end

  def generate_token(usuario) do
    case Guardian.encode_and_sign(usuario) do
      {:ok, token, _claims} -> {:ok, token}
      {:error, reason} -> {:error, reason}
    end
  end

  def verify_token(token) do
    case Guardian.decode_and_verify(token) do
      {:ok, claims} -> Guardian.resource_from_claims(claims)
      {:error, reason} -> {:error, reason}
    end
  end
end
