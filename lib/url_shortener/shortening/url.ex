defmodule UrlShortener.Shortening.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :slug, :string
    field :original_url, :string
    field :visits, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  # TODO: add URL validation to original_url
  # TODO: do we need to cast unused attrs?
  # TODO: add slug generation to create_url
  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:slug, :original_url, :visits])
    |> validate_required([:original_url])
  end

  @doc false
  def generate_slug(url_changeset) do
    # TODO: change to dynamic generation
    put_change(url_changeset, :slug, "abc")
  end
end
