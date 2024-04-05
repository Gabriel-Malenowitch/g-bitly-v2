defmodule SimpleCrud.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :url_name, :string
    field :redirect_url_name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:url_name, :redirect_url_name])
    |> validate_required([:url_name, :redirect_url_name])
  end
end
