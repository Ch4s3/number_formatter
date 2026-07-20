defmodule NumberFormatter.Mixfile do
  use Mix.Project

  @source_url "https://github.com/Ch4s3/number_formatter"
  @version "1.0.5"

  def project do
    [
      app: :number_formatter,
      description: "Convert numbers to various string formats, such as currency",
      version: @version,
      elixir: "~> 1.16",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def cli do
    [
      preferred_envs: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.github": :test
      ]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:decimal, "~> 3.0"},
      {:credo, ">= 1.7.0", only: [:dev, :test], runtime: false},
      {:excoveralls, ">= 0.16.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test]},
      {:inch_ex, ">= 0.0.0", only: [:dev, :test]}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      extras: ["CHANGELOG.md", "README.md"]
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "CHANGELOG.md", "LICENSE"],
      maintainers: ["Daniel Berkompas"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "https://hexdocs.pm/number_formatter/changelog.html",
        "GitHub" => @source_url
      }
    ]
  end
end
