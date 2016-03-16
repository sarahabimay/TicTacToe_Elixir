defmodule BoardDisplayTest do
  use ExUnit.Case
  doctest TTT
  alias TTT.Board
  alias TTT.BoardDisplay

  test "it displays HVH game with 3x3 board" do
    row1_display = "1 | 2 | 3\n"
    row2_display = "4 | 5 | 6\n"
    row3_display = "7 | 8 | 9\n"
    row_divider = "____________\n"
    expected = row1_display <> row_divider <> row2_display <> row_divider <> row3_display
    dimension = 3
    empty_board = Board.empty_board(dimension)
    assert BoardDisplay.formatted_board(empty_board) == expected
  end

  test "it displays HVH game with 4x4 board" do
    row1_display = "1 | 2 | 3 | 4\n"
    row2_display = "5 | 6 | 7 | 8\n"
    row3_display = "9 | 10 | 11 | 12\n"
    row4_display = "13 | 14 | 15 | 16\n"
    row_divider = "____________\n"
    expected = row1_display <> row_divider <> row2_display <> row_divider <> row3_display <> row_divider <> row4_display
    dimension = 4
    empty_board = Board.empty_board(dimension)
    assert BoardDisplay.formatted_board(empty_board) == expected
  end
end
