defmodule ProjectManagerApiWs.Proyectos do
  @moduledoc """
  The Proyectos context.
  """

  import Ecto.Query, warn: false
  alias ProjectManagerApiWs.Repo

  alias ProjectManagerApiWs.Proyectos.Proyecto

  @doc """
  Returns the list of proyectos.

  ## Examples

      iex> list_proyectos()
      [%Proyecto{}, ...]

  """
  def list_proyectos do
    Repo.all(Proyecto)
  end

  @doc """
  Gets a single proyecto.

  Raises `Ecto.NoResultsError` if the Proyecto does not exist.

  ## Examples

      iex> get_proyecto!(123)
      %Proyecto{}

      iex> get_proyecto!(456)
      ** (Ecto.NoResultsError)

  """
  def get_proyecto!(id), do: Repo.get!(Proyecto, id)

  @doc """
  Creates a proyecto.

  ## Examples

      iex> create_proyecto(%{field: value})
      {:ok, %Proyecto{}}

      iex> create_proyecto(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_proyecto(attrs \\ %{}) do
    %Proyecto{}
    |> Proyecto.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a proyecto.

  ## Examples

      iex> update_proyecto(proyecto, %{field: new_value})
      {:ok, %Proyecto{}}

      iex> update_proyecto(proyecto, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_proyecto(%Proyecto{} = proyecto, attrs) do
    proyecto
    |> Proyecto.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a proyecto.

  ## Examples

      iex> delete_proyecto(proyecto)
      {:ok, %Proyecto{}}

      iex> delete_proyecto(proyecto)
      {:error, %Ecto.Changeset{}}

  """
  def delete_proyecto(%Proyecto{} = proyecto) do
    Repo.delete(proyecto)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking proyecto changes.

  ## Examples

      iex> change_proyecto(proyecto)
      %Ecto.Changeset{data: %Proyecto{}}

  """
  def change_proyecto(%Proyecto{} = proyecto, attrs \\ %{}) do
    Proyecto.changeset(proyecto, attrs)
  end
end
