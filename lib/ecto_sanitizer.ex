defmodule EctoSanitizer do
  @moduledoc """
  Provides functions for sanitizing `Ecto.Changeset` inputs.
  """

  @doc """
  Sanitizes all changes in the given changeset that apply to field which are of
  the `:string` `Ecto` type.

  Uses the `HtmlSanitizeEx.strip_tags/1` function on any change that satisfies
  all of the following conditions:

  1. The field associated with the change is of the type `:string`.
  2. The field associated with the change is not in the blacklisted_fields list
     of `opts` as defined using the `:except` key in `opts`.

  Note that this function will change the value in the `:changes` map of an
  `%Ecto.Changeset{}` struct if the given changes are sanitized.

  ## Examples

      iex> attrs = %{string_field: "<script>Bad</script>"}
      iex> result_changeset =
      ...>   attrs
      ...>   |> FakeEctoSchema.changeset()
      ...>   |> EctoSanitizer.sanitize_all_strings()
      iex> result_changeset.changes
      %{string_field: "Bad"}

  Fields can be exempted from sanitization via the `:except` option.
      iex> attrs = %{string_field: "<script>Bad</script>"}
      iex> result_changeset =
      ...>   attrs
      ...>   |> FakeEctoSchema.changeset()
      ...>   |> EctoSanitizer.sanitize_all_strings(except: [:string_field])
      iex> result_changeset.changes
      %{string_field: "<script>Bad</script>"}
  """
  def sanitize_all_strings(%Ecto.Changeset{} = changeset, opts \\ []) do
    blacklisted_fields = Keyword.get(opts, :except, [])

    sanitized_changes =
      Enum.into(changeset.changes, %{}, fn change ->
        strip_html_from_change(change, blacklisted_fields, changeset.types)
      end)

    %{changeset | changes: sanitized_changes}
  end

  defp strip_html_from_change({field, value}, blacklisted_fields, types) when is_binary(value) do
    if field in blacklisted_fields do
      {field, value}
    else
      if Map.get(types, field) == :string do
        {field, HtmlSanitizeEx.strip_tags(value)}
      else
        {field, value}
      end
    end
  end

  defp strip_html_from_change(change, _, _), do: change
end
