defmodule Nodelix.SigilNode do
  defp tmp_filename() do
    suffix = :crypto.strong_rand_bytes(32) |> Base.encode16() |> String.slice(0..31)
    "nodelix_" <> suffix <> ".js"
  end

  defp get_tmp_path() do
    Path.join(System.tmp_dir!(), tmp_filename())
  end

  @doc """
  Convenience macro to circumvent the lack of interpolation in multiline sigils.
  """
  defmacro node_script(do_block) do
    {:sigil_NODE, [delimiter: "\"\"\"", context: Elixir.Nodelix.SigilNode, imports: []],
     [
       {:<<>>, [indentation: 0],
        [
          Keyword.get(do_block, :do)
        ]},
       []
     ]}
  end

  def sigil_NODE(body, _opts) do
    filename = get_tmp_path()
    File.write!(filename, body)
    filename
  end
end
