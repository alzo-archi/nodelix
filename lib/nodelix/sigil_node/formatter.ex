defmodule Nodelix.SigilNode.Formatter do
  @behaviour Mix.Tasks.Format

  def features(_opts) do
    [sigils: [:NODE], extensions: []]
  end

  def format(contents, opts) do
    parser =
      case opts[:sigil] do
        :NODE -> "acorn"
      end

    c = """
    <<'EOF'
    #{contents}
    EOF
    """

    command = "prettier --parser #{parser} #{c}"
    port = Port.open({:spawn, command}, [:binary])

    receive do
      {^port, {:data, d}} -> d
      _ -> contents
    end
  rescue
    _ -> contents
  end
end
