defmodule OptionsDisplayTest do
  use ExUnit.Case
  alias TTT.Console.OptionsDisplay

  test "board size options are formatted correctly" do
    expected = "[1] 3X3\n[2] 4X4\n"
    result = OptionsDisplay.board_size_options()
    assert result == expected
  end

  test "game type options are formatted correctly" do
    expected =
    "[1] Human VS Human\n" <>
    "[2] Human VS Beatable\n" <>
    "[3] Beatable VS Human\n" <>
    "[4] Human VS Unbeatable\n" <>
    "[5] Unbeatable VS Human\n"
    result = OptionsDisplay.game_type_options()
    assert result == expected
  end
end
