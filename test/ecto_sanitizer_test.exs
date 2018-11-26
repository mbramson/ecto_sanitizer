defmodule EctoSanitizerTest do
  use ExUnit.Case, async: true
  doctest EctoSanitizer

  describe "sanitize_all_strings/2" do
    test "strips html from string fields" do
      attrs = %{
        string_field: "<script>Text</script>",
        other_string_field: "<a>Text</a>"
      }

      result =
        attrs
        |> FakeEctoSchema.changeset()
        |> EctoSanitizer.sanitize_all_strings()

      assert result.changes == %{string_field: "Text", other_string_field: "Text"}
    end

    test "properly handles blacklisted fields" do
      attrs = %{
        string_field: "<script>Text</script>"
      }

      result =
        attrs
        |> FakeEctoSchema.changeset()
        |> EctoSanitizer.sanitize_all_strings(except: [:string_field])

      assert result.changes == %{string_field: "<script>Text</script>"}
    end

    test "does not sanitize a non-string field when change is a binary" do
      attrs = %{
        binary_field: "<script>Text</script>"
      }

      result =
        attrs
        |> FakeEctoSchema.changeset()
        |> EctoSanitizer.sanitize_all_strings()

      assert result.changes == %{binary_field: "<script>Text</script>"}
    end

    test "does not error when given an integer field" do
      attrs = %{int_field: 123}

      result =
        attrs
        |> FakeEctoSchema.changeset()
        |> EctoSanitizer.sanitize_all_strings()

      assert result.changes == %{int_field: 123}
    end
  end
end
