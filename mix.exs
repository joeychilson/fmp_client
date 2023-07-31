defmodule FMP.MixProject do
  use Mix.Project

  @version "0.3.0"
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
      extra_applications: [:logger, :req, :jason]
    ]
  end

  defp deps do
    [
      {:req, "~> 0.3.11"},
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
