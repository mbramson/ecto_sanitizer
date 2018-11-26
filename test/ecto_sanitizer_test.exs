defmodule EctoSanitizerTest do
  use ExUnit.Case, async: true
  doctest EctoSanitizer

  describe "sanitize_all_strings/2" do
    test "strips html from string fields" do
      attrs = %{
        string_field: "<script>Text</script>",
        other_string_field: "<a>Text</a>"
      }

      result = attrs
               |> FakeEctoSchema.changeset
               |> EctoSanitizer.sanitize_all_strings

      assert result.changes == %{string_field: "Text", other_string_field: "Text"}
    end
  end
end
