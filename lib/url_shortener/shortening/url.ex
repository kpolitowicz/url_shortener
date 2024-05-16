defmodule UrlShortener.Shortening.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :slug, :string
    field :original_url, :string
    field :visits, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:slug, :original_url, :visits])
    |> validate_required([:slug, :original_url, :visits])
  end
end
