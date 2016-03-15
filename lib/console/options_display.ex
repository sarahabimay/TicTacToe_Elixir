defmodule TTT.OptionsDisplay do
  alias TTT.Options

  def board_size_options() do
    Options.board_size_options()
    |> with_index
    |> Enum.reverse
    |> options_for_display
  end

  def game_type_options() do
    Options.game_type_options()
    |> with_index
    |> Enum.reverse
    |> options_for_display
  end

  defp with_index(options) do
    options
    |> Enum.with_index
    |> Enum.map(fn({element, index}) -> {element, index+1} end)
  end

  defp options_for_display(options) do
    Enum.reduce(options, "", fn({option, index}, acc) -> "[#{index}] #{option}\n#{acc}" end)
  end
end
