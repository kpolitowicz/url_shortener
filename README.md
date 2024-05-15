# UrlShortener

## TODO

* change the port to 8080!
* setup docker
* implement requirements
* profit!

## Setup

### Docker

TBA

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
* `mix phx.server` to test http://localhost:4000
