defmodule OptionsDisplayTest do
  use ExUnit.Case
  doctest TTT
  alias TTT.OptionsDisplay

  test "board size options are formatted correctly" do
    expected = "[1] 3X3\n"
    result = OptionsDisplay.board_size_options()
    assert result == expected
  end

  test "game type options are formatted correctly" do
    expected = "[1] Human VS Human\n[2] Human VS Computer\n[3] Computer VS Human\n"
    result = OptionsDisplay.game_type_options()
    assert result == expected
  end
end
