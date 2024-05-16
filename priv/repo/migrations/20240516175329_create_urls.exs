defmodule UrlShortener.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :slug, :string
      add :original_url, :string
      add :visits, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
