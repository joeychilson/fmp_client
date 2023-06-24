defmodule FMP.MixProject do
  use Mix.Project

  @version "0.1.0"
  @description "An Elixir-based HTTP Client for financialmodelingprep.com"

  def project do
    [
      app: :fmp_client,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: @description,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :httpoison, :jason]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 2.1"},
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/joeychilson/fmp_client"},
      maintainers: ["Joey Chilson"]
    ]
  end
end
