defmodule UrlShortener.Shortening.Url do
  use Ecto.Schema
  import Ecto.Changeset
  alias UrlShortener.Shortening.Slug

  # Only basic http/https protocol validation is covered for now.
  # If need be this can be adjusted to emerging requirement, e.g other protocols
  # or even full URI RFC spec.
  @valid_url_regex ~r/^https?:\/\//

  schema "urls" do
    field :slug, :string
    field :original_url, :string
    field :visits, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:original_url])
    |> validate_required([:original_url])
    |> validate_format(:original_url, @valid_url_regex)
  end

  @doc false
  def generate_slug(url_changeset) do
    put_change(url_changeset, :slug, Slug.generate())
  end
end
