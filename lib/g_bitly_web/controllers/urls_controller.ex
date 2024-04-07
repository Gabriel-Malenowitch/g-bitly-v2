
defmodule GBitlyWeb.URLsController do
  use GBitlyWeb, :controller

  alias GBitly.UrlApi.Service

  def list_all(conn, _params) do
    case Service.get_all() do
      {:ok, %{result: result}} -> json(conn, result.rows)
      {:error, err} -> IO.inspect(err)
    end
  end

  def create(conn, %{"from" => from, "to" => to}) do
    case Service.verify_if_exists_url(from) do
      {:exist} -> json(conn, "URL já existe.")
      # Is the life if we have a error in next line
      {:non_exist} -> case Service.insert_new_url_from_to(from, to) do
        {:ok, _} -> json(conn, "Criado com sucesso.")
      end
      {:error, _} -> json(conn, "Tivemos um problema.")
     end
  end

  def my_redirect(conn, %{"to" => to}) do
    case Service.get_correspondent_url_by_name(to) do
      {:ok, %{result: result}} -> redirect(conn, external: concat_url(result))
      {:error, _} -> json(conn, "Não encontramos seu link na nossa base de dados.")
    end
  end

  defp concat_url(url) do
    if url =~ ~r(https?:\/\/), do: url, else: "https://" <> url
  end
end
