alias GBitly.Repo
alias GBitly.UrlApi

defmodule GBitlyWeb.URLsController do
  use GBitlyWeb, :controller

  def list_all(conn, _params) do
    case Repo.query("select * from urls") do
      {:ok, result} -> json(conn, result.rows)
      {:error, err} -> IO.inspect(err)
    end
  end

  def create(conn, %{"from" => from, "to" => to}) do
    case UrlApi.verify_if_exists_url(from) do
      {:exist} -> json(conn, "URL já existe.")
      # Is the life if we have a error in next line
      {:non_exist} -> with {:ok, _} <- UrlApi.insert_new_url_from_to(from, to) do
        json(conn, "Criado com sucesso.")
      end
      {:error, _} -> json(conn, "Tivemos um problema.")
     end
  end

  def my_redirect(conn, %{"to" => to}) do
    case UrlApi.get_correspondent_url_by_name(to) do
      {:ok, result} -> redirect(conn, external: concat_url(result))
      {:error, _} -> json(conn, "Não encontramos seu link na nossa base de dados.")
    end
  end

  defp concat_url(url) do
    if url =~ ~r(https?:\/\/), do: url, else: "https://" <> url
  end
end
