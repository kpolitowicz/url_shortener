defmodule UrlShortenerWeb.UrlControllerTest do
  use UrlShortenerWeb.ConnCase

  import UrlShortener.ShorteningFixtures

  @create_attrs %{
    original_url:
      "https://www.google.com/search?q=url+shortener&oq=google+u" <>
      "&aqs=chrome.0.69i59j69i60l3j0j69i57.1069j0j7&sourceid=chrome&ie=UTF-8"
  }
  @update_attrs %{original_url: "http://google.com"}
  @invalid_attrs %{slug: nil, original_url: nil, visits: nil}

  describe "index" do
    test "lists all urls", %{conn: conn} do
      conn = get(conn, ~p"/urls")
      assert html_response(conn, 200) =~ "Listing Urls"
    end
  end

  describe "new url" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/urls/new")
      assert html_response(conn, 200) =~ "Shorten a long link"
    end
  end

  describe "create url" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/urls", url: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/urls/#{id}"

      conn = get(conn, ~p"/urls/#{id}")
      assert html_response(conn, 200) =~ "Url #{id}"
    end

    # TODO: change this to test original_url validation (TBA)
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/urls", url: @invalid_attrs)
      assert html_response(conn, 200) =~ "Shorten a long link"
    end
  end

  describe "edit url" do
    setup [:create_url]

    test "renders form for editing chosen url", %{conn: conn, url: url} do
      conn = get(conn, ~p"/urls/#{url}/edit")
      assert html_response(conn, 200) =~ "Edit Url"
    end
  end

  describe "update url" do
    setup [:create_url]

    test "redirects when data is valid", %{conn: conn, url: url} do
      conn = put(conn, ~p"/urls/#{url}", url: @update_attrs)
      assert redirected_to(conn) == ~p"/urls/#{url}"

      conn = get(conn, ~p"/urls/#{url}")
      assert html_response(conn, 200) =~ "http://google.com"
    end

    test "renders errors when data is invalid", %{conn: conn, url: url} do
      conn = put(conn, ~p"/urls/#{url}", url: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Url"
    end
  end

  describe "delete url" do
    setup [:create_url]

    test "deletes chosen url", %{conn: conn, url: url} do
      conn = delete(conn, ~p"/urls/#{url}")
      assert redirected_to(conn) == ~p"/urls"

      assert_error_sent 404, fn ->
        get(conn, ~p"/urls/#{url}")
      end
    end
  end

  defp create_url(_) do
    url = url_fixture()
    %{url: url}
  end
end
