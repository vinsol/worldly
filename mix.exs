defmodule Worldly.Mixfile do
  use Mix.Project

  def project do
    [app: :worldly,
     version: "0.1.0",
     description: description(),
     package: package(),
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :yamerl]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:yamerl, github: "yakaz/yamerl"}]
  end

  defp package do
    [
      name: :worldly,
      files: ["config", "lib", "data", "test", "test_data", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Pikender Sharma", "Nimish Mehta"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/vinsol/worldly",
      "Docs" => "http://vinsol.github.io/worldly/"}]
  end

  defp description do
    "Includes Country and Region data from the Debian iso-data project and helpers"
  end
end
