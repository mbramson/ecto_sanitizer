defmodule FakeEctoSchema do
  @moduledoc """
  Ecto Schema to be used for testing custom validations.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "fake_table" do
    field(:string_field, :string)
    field(:other_string_field, :string)
    field(:int_field, :integer)
  end

  @fields ~w(string_field other_string_field int_field)a

  def changeset(attrs) do
    changeset(%FakeEctoSchema{}, attrs)
  end
  def changeset(%FakeEctoSchema{} = fake_ecto_schema, attrs) do
    cast(fake_ecto_schema, attrs, @fields)
  end
end
