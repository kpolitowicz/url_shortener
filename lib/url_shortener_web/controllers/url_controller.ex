defmodule UrlShortenerWeb.UrlController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Shortening
  alias UrlShortener.Shortening.Url

  def index(conn, _params) do
    urls = Shortening.list_urls()
    render(conn, :index, urls: urls)
  end

  def new(conn, _params) do
    changeset = Shortening.change_url(%Url{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"url" => url_params}) do
    case Shortening.create_url(url_params) do
      {:ok, url} ->
        conn
        |> put_flash(:info, "Url created successfully.")
        |> redirect(to: ~p"/urls/#{url}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    url = Shortening.get_url!(id)
    render(conn, :show, url: url)
  end

  def edit(conn, %{"id" => id}) do
    url = Shortening.get_url!(id)
    changeset = Shortening.change_url(url)
    render(conn, :edit, url: url, changeset: changeset)
  end

  def update(conn, %{"id" => id, "url" => url_params}) do
    url = Shortening.get_url!(id)

    case Shortening.update_url(url, url_params) do
      {:ok, url} ->
        conn
        |> put_flash(:info, "Url updated successfully.")
        |> redirect(to: ~p"/urls/#{url}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, url: url, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    url = Shortening.get_url!(id)
    {:ok, _url} = Shortening.delete_url(url)

    conn
    |> put_flash(:info, "Url deleted successfully.")
    |> redirect(to: ~p"/urls")
  end
end
