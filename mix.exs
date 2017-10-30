defmodule Xyz.Mixfile do
  use Mix.Project

  def project do
    [
      app: :xyz,
      deps: deps(),
      description: description(),
      dialyzer: [
        plt_add_deps: true
      ],
      elixir: "~> 1.5",
      name: "Xyz",
      package: package(),
      preferred_cli_env: ["coveralls": :test,
                          "coveralls.detail": :test,
                          "coveralls.post": :test,
                          "coveralls.html": :test],
      start_permanent: Mix.env == :prod,
      test_coverage: [tool: ExCoveralls],
      version: "0.1.1",
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo,        "~> 0.8.8", only: [:dev], runtime: false},
      {:dialyxir,    "~> 0.5.1",  only: [:dev], runtime: false},
      {:earmark,     "~> 1.2.2",  only: [:dev], runtime: false},
      {:excoveralls, "~> 0.7.4",  only: [:test], runtime: false},
      {:ex_doc,      "~> 0.18.1", only: [:dev], runtime: false},
      {:inch_ex,     "~> 0.5.6",  only: [:dev], runtime: false},
      {:plug,        "~> 1.4 or ~> 1.3.3 or ~> 1.2.4 or ~> 1.1.8 or ~> 1.0.5"}
    ]
  end

  defp description() do
    "Gzip response if gzip is sent as a value in the accept-encoding header"
  end

  defp package() do
    [
      files: ["lib",  "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Ben Marx"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/bgmarx/xyz"}
    ]
  end
end
