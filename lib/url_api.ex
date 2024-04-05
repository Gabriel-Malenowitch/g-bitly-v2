alias GBitly.Repo

defmodule GBitly.UrlApi do
  def verify_if_exists_url(from) do
    case Repo.query("SELECT COUNT(*) AS total FROM urls WHERE url_name LIKE '#{from}'") do
      # {:ok, result} -> IO.inspect(result)
      {:ok, %{rows: [[ total ]]}} when total > 0 -> {:exist}
      {:ok, _} -> {:non_exist}
      {:error, result} -> {:error, result: result}
    end
  end

  def insert_new_url_from_to(from, to) do
    case Repo.query("INSERT INTO urls (url_name, redirect_url_name) VALUES ('#{from}', '#{to}')") do
      {:ok, result} -> {:ok, result: result}
      {:error, result} -> {:error, result: result}
    end
  end

  def get_correspondent_url_by_name(to) do
    case Repo.query("SELECT redirect_url_name FROM urls WHERE url_name = '#{to}'") do
      {:ok, %{ rows: [[result]] }} -> {:ok, result}
      {:error, result} -> {:error, result: result}
    end
  end
end
