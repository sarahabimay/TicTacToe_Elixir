defmodule BoardDisplayTest do
  use ExUnit.Case
  alias TTT.Board.Board
  alias TTT.Console.BoardDisplay

  test "it displays HVH game with 3x3 board" do
    dimension = 3
    expected = board_for_display(dimension)
    empty_board = Board.empty_board(dimension)
    assert BoardDisplay.formatted_board(empty_board) == expected
  end

  test "it displays HVH game with 4x4 board" do
    dimension = 4
    expected = board_for_display(dimension)
    empty_board = Board.empty_board(dimension)
    assert BoardDisplay.formatted_board(empty_board) == expected
  end

  def board_for_display(3) do
    row1_display = "[  1 ][  2 ][  3 ]\n"
    row2_display = "[  4 ][  5 ][  6 ]\n"
    row3_display = "[  7 ][  8 ][  9 ]\n"
    row1_display <> row2_display <> row3_display
  end

  def board_for_display(4) do
    row1_display = "[  1 ][  2 ][  3 ][  4 ]\n"
    row2_display = "[  5 ][  6 ][  7 ][  8 ]\n"
    row3_display = "[  9 ][ 10 ][ 11 ][ 12 ]\n"
    row4_display = "[ 13 ][ 14 ][ 15 ][ 16 ]\n"
    row1_display <> row2_display <> row3_display <> row4_display
  end
end

