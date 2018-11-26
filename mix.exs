defmodule EctoSanitizer.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_sanitizer,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      name: "EctoSanitizer",
      source_url: "https://github.com/mbramson/ecto_sanitizer",
      package: package(),
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
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ecto, ">= 2.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:html_sanitize_ex, "~> 1.3.0"},
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false}
    ]
  end

  defp description() do
    """
    EctoSanitizer is a libary for sanitizing inputs to Ecto Changesets.
    """
  end

  defp package() do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Mathew Bramson"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mbramson/ecto_sanitizer"}
    ]
  end
end
