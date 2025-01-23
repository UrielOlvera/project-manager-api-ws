defmodule ProjectManagerApiWsWeb.AuthController do
  use ProjectManagerApiWsWeb, :controller

  alias ProjectManagerApiWs.Usuarios
  alias ProjectManagerApiWs.Guardian
  alias ProjectManagerApiWsWeb.ChangesetJSON

  def register(conn, params) do
    with {:ok, usuario} <- Usuarios.create_usuario(params) do
      conn
      |> put_status(:created)
      |> json(%{message: "Usuario registrado exitosamente", data: usuario})
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: ChangesetJSON.error(changeset)})
    end
  end

  def login(conn, %{"correo" => correo, "contrasena" => contrasena}) do
    case Usuarios.authenticate(correo, contrasena) do
      {:ok, usuario} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(usuario, %{}, ttl: {1, :hour})
        json(conn, %{token: token, usuario: usuario})

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Correo o contraseña incorrectos"})
    end
  end

  def login(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Parámetros inválidos"})
  end

  def logout(conn, _params) do
    IO.inspect(conn)
    token = Guardian.Plug.current_token(conn) |> IO.inspect()
    case Guardian.revoke(token) do
      :ok ->
        conn
        |> put_status(:ok)
        |> json(%{message: "Sesión cerrada correctamente"})

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Error al cerrar sesión"})
    end
  end

end
