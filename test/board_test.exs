defmodule BoardTest do
  use ExUnit.Case
  doctest TTT
  alias TTT.Board, as: Board

  test "it returns an empty 3x3 board" do
    dimension = 3
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    expected_board = row1 ++ row2 ++ row3
    assert Board.empty_board(dimension) == expected_board
  end

  test "the rows can be extracted from board" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert Board.rows(board) == [row1, row2, row3]
  end

  test "the columns can be extracted from board" do
    diag1 = [1, 5, 9]
    diag2 = [7, 5, 3]
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert Board.diagonals(board) == [diag1, diag2]
  end

  test "the diagonals can be extracted from board" do
  end
end
