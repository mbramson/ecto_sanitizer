# EctoSanitizer

Provides functions for sanitizing `Ecto.Changeset` fields.

## Usage

Uses the [`HtmlSanitizeEx`](https://github.com/rrrene/html_sanitize_ex) library
to sanitize all string fields in an `%Ecto.Changeset{}` struct.

See https://hexdocs.pm/ecto_sanitizer/EctoSanitizer.html#sanitize_all_strings/2 for usage examples.

## Installation

The package can be installed by adding `ecto_sanitizer` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_sanitizer, "~> 0.1.0"}
  ]
end
```

Documentation can be found at [https://hex.pm/ecto_sanitizer](https://hex.pm/ecto_sanitizer)
