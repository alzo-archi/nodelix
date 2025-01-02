defmodule Nodelix.Samples.BlockUsage do
  import Nodelix.SigilNode
  alias Nodelix.VersionManager

  def hello_from_node_script(target) do
    node_script do
      """
      console.log("Hello #{target} !")
      """
    end
  end

  def run_sample() do
    vsn = VersionManager.latest_lts_version()

    if !VersionManager.is_installed?(vsn) do
      VersionManager.install(vsn)
    end

    script = hello_from_node_script("world")
    Nodelix.run_standalone(vsn, script, erase: true)
  end
end
