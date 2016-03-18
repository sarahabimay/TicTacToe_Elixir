defmodule BoardTest do
  use ExUnit.Case
  doctest TTT
  alias TTT.Board

  test "it returns an empty 3x3 board" do
    dimension = 3
    expected_board = expected_board(dimension)
    assert Board.empty_board(dimension) == expected_board
  end

  test "it returns an empty 4x4 board" do
    dimension = 4
    expected_board = expected_board(dimension)
    assert Board.empty_board(dimension) == expected_board
  end

  test "the rows can be extracted from board" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    dimension = 3
    board = expected_board(dimension)
    assert Board.rows(board) == [row1, row2, row3]
  end

  test "the columns can be extracted from board" do
    diag1 = [1, 5, 9]
    diag2 = [7, 5, 3]
    dimension = 3
    board = expected_board(dimension)
    assert Board.diagonals(board) == [diag1, diag2]
  end

  def expected_board(3) do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    row1 ++ row2 ++ row3
  end

  def expected_board(4) do
    row1 = [1,  2,  3,  4]
    row2 = [5,  6,  7,  8]
    row3 = [9, 10, 11, 12]
    row4 = [13,14, 15, 16]
    row1 ++ row2 ++ row3 ++ row4
  end
end
