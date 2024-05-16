# UrlShortener

## TODO

* implement requirements
* maybe add scripts to test the min load requirements
* maybe add dev docker setup (via devcontainers or just MIX_ENV=dev)
* profit!

## Setup

### Docker

TODO: check if `docker-compose run web "/app/bin/migrate"` is required (after migrations are added)

* Run `docker-compose up -d`
* Access the app at http://localhost:8080

Note: this boots the app in prod environment.

### Native (Mac OSX) development

Note: native setup might be preferred by some for local development. The instructions provided below
assume Mac OSX with standard development tools (XCode, homebrew, git, gh, asdf) installed. `asdf` is
Erlang/Elixir version manager of choice - adjust these steps if you use something else. Omit the steps
if you have a component (e.g. elixir, postgres) already installed.

Install the latest Erlang/Elixir:

* `asdf install erlang 26.2.5`
* `asdf install elixir 1.16.2`
* `asdf global erlang 26.2.5`
* `asdf global elixir 1.16.2`

Install and configure postgres:

* `brew install postgresql@16`
* `brew services start postgresql@16`
* `psql postgres`
  - `> CREATE USER postgres WITH PASSWORD 'postgres';`
  - `> ALTER USER postgres CREATEDB;`

Clone and set up the app:

* `git clone https://github.com/kpolitowicz/url_shortener.git`
* `cd url_shortener`
* `mix setup`
* `mix phx.server` to test http://localhost:8080
