defmodule EctoSanitizer.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_sanitizer,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end


  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:ecto, ">= 2.0.0"},
      {:html_sanitize_ex, "~> 1.3.0"}
    ]
  end
end
