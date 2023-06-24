defmodule FMP.MixProject do
  use Mix.Project

  def project do
    [
      app: :fmp_client,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :jason]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.1"},
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end
end
