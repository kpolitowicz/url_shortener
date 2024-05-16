defmodule UrlShortener.ShorteningTest do
  use UrlShortener.DataCase

  alias UrlShortener.Shortening

  describe "urls" do
    alias UrlShortener.Shortening.Url

    import UrlShortener.ShorteningFixtures

    @invalid_attrs %{slug: nil, original_url: nil, visits: nil}

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert Shortening.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Shortening.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      valid_attrs = %{slug: "some slug", original_url: "some original_url", visits: 42}

      assert {:ok, %Url{} = url} = Shortening.create_url(valid_attrs)
      assert url.slug == "some slug"
      assert url.original_url == "some original_url"
      assert url.visits == 42
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortening.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      update_attrs = %{slug: "some updated slug", original_url: "some updated original_url", visits: 43}

      assert {:ok, %Url{} = url} = Shortening.update_url(url, update_attrs)
      assert url.slug == "some updated slug"
      assert url.original_url == "some updated original_url"
      assert url.visits == 43
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortening.update_url(url, @invalid_attrs)
      assert url == Shortening.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %Url{}} = Shortening.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Shortening.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Shortening.change_url(url)
    end
  end
end
