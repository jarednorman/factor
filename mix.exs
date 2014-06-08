defmodule Factor.Mixfile do
  use Mix.Project

  def project do
    [ app: :factor,
      version: "0.0.1",
      elixir: "~> 0.13.3",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ registered: [:factor],
      mod: {Factor, []} ]
  end

  defp deps do
    []
  end
end
