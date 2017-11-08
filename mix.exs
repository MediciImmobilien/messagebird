defmodule Messagebird.Mixfile do
  use Mix.Project

  def project do
    [app: :messagebird,
     version: "0.1.0",
     build_path: "_build",
     deps_path: "deps",
     lockfile: "mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end


  def application do

    [extra_applications: [:logger]]
  end

 
  defp deps do
    [{:poison, "~> 3.1",override: :true}, {:httpoison, "~> 0.11.0"}]
  end
end
