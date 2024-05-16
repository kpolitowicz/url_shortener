defmodule UrlShortener.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :slug, :string, null: false
      add :original_url, :string, null: false
      add :visits, :integer, null: false, default: 0

      timestamps(type: :utc_datetime)
    end

    create unique_index(:urls, [:slug])
  end
end
