defmodule EctoSanitizer do
  @moduledoc """
  Provides functions for sanitizing `Ecto.Changeset` inputs.
  """

  def sanitize_all_strings(%Ecto.Changeset{} = changeset, opts \\ []) do
    blacklisted_fields = Keyword.get(opts, :except, [])

    changes = changeset.changes
    types = changeset.types

    sanitized_changes =
      Enum.into(changeset.changes, %{}, fn change ->
        strip_html_from_change(change, blacklisted_fields, types)
      end)

    %{changeset | changes: sanitized_changes}
  end

  defp strip_html_from_change({field, value}, blacklisted_fields, types) when is_binary(value) do
    if field in blacklisted_fields do
      {field, value}
    else
      {field, HtmlSanitizeEx.strip_tags(value)}
    end
  end

  defp strip_html_from_change(change, _, _), do: change
end
