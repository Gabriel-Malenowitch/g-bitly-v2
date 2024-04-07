alias GBitly.Repo

defmodule GBitly.UrlApi.Service do
  alias GBitly.Url.Repo

  def verify_if_exists_url(from) do
    case Repo.get_length_by_url_name(from) do
      {:ok, %{rows: [[ total ]]}} when total > 0 -> {:exist}
      {:ok, _} -> {:non_exist}
      {:error, result} -> {:error, %{result: result}}
    end
  end

  def insert_new_url_from_to(from, to) do
    case Repo.insert(from, to) do
      {:ok, result} -> {:ok, %{result: result}}
      {:error, result} -> {:error, %{result: result}}
    end
  end

  def get_correspondent_url_by_name(to) do
    case Repo.get_url_redirect_name_by_url_name(to) do
      {:ok, %{ rows: [[result]] }} -> {:ok, %{result: result}}
      {:error, result} -> {:error, %{result: result}}
    end
  end

  def get_all() do
    case Repo.get_all() do
      {:ok, result} -> {:ok, %{result: result}}
      {:error, result} -> {:error, %{result: result}}
    end
  end
end
