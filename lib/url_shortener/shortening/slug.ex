# Design note:
# The generation code does not guarantee uniqueness of generated slugs. Meaning
# the non-unique slug will fail on DB contraint.
#
# This is an acceptable trade-off on the app launch. With 7 base62 charactes, the slug has
# over 3.5 trillion possible values. Even if we expect 5 url shortening requests per second
# (totalling ~157M records per year) the chance of slug collision is negligible (under 0.005%)
# and all user has to do if that happens is to retry.
#
# Adding additional measures like retrying create_url call or checking for non-uniqueness on the
# app level would be an ober-engineering at this point.
#
defmodule UrlShortener.Shortening.Slug do
  @default_slug_len 7

  @doc false
  def generate() do
    string_of_length(@default_slug_len)
  end

  # Borrowed and customized from:
  # https://stackoverflow.com/questions/32001606/how-to-generate-a-random-url-safe-string-with-elixir
  @chars "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" |> String.split("", trim: true)

  defp string_of_length(length) do
    Enum.reduce((1..length), [], fn (_i, acc) ->
      [Enum.random(@chars) | acc]
    end) |> Enum.join("")
  end
end
