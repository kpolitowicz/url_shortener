defmodule UrlShortener.ShorteningFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UrlShortener.Shortening` context.
  """

  @doc """
  Generate a url.
  """
  def url_fixture(attrs \\ %{}) do
    {:ok, url} =
      attrs
      |> Enum.into(%{
        original_url: "https://www.google.com/"
      })
      |> UrlShortener.Shortening.create_url()

    url
  end
end
