defmodule GBitly.Url.Repo do
  alias GBitly.Repo
  # alias GBitly.UrlSchema

  def get_all() do
    Repo.query("select * from urls")
  end

  def get_length_by_url_name(from) do
    Repo.query("SELECT COUNT(*) AS total FROM urls WHERE url_name LIKE '#{from}'")
  end

  def insert(from, to) do
    Repo.query("INSERT INTO urls (url_name, redirect_url_name) VALUES ('#{from}', '#{to}')")
    # UrlSchema.changeset(%UrlSchema{}, %{url_name: from, redirect_url_name: to})
    # |> Repo.insert()
  end

  def get_url_redirect_name_by_url_name(to) do
    Repo.query("SELECT redirect_url_name FROM urls WHERE url_name = '#{to}'")
  end
end
