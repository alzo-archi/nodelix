defmodule Nodelix.Samples.SigilUsage do
  import Nodelix.SigilNode
  alias Nodelix.VersionManager

  def hello_from_node_script() do
    sigil_NODE(
      """
      console.log("Hello world !")
      """,
      []
    )
  end

  def run_sample() do
    vsn = VersionManager.latest_lts_version()

    if !VersionManager.is_installed?(vsn) do
      VersionManager.install(vsn)
    end

    script = hello_from_node_script()
    Nodelix.run_standalone(vsn, script, erase: true)
  end
end
