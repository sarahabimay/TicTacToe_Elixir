defmodule DisplayBoardTest do
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
    empty_board = Board.empty_board()
    assert BoardDisplay.formatted_board(empty_board) == expected
  end
end
