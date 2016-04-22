defmodule BoardResultTest do
  use ExUnit.Case
  doctest TTT
  alias TTT.Board.BoardResult

  test "no winner found" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert BoardResult.found_winner?(board) == false
  end

  test "game is over if no positions remain" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"X"]
    row3 = ["O", "X", "O"]
    board = row1 ++ row2 ++ row3
    assert BoardResult.game_over?(board) == true
  end

  test "game is over when there is a win" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"O"]
    row3 = [7, 8, "X" ]
    board = [row1, row2, row3]
    assert BoardResult.game_over?(board) == true
  end

  test "it has a diagonal win" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"O"]
    row3 = ["7", "8", "X" ]
    board = [row1, row2, row3]
    assert BoardResult.found_winner?(board) == true
  end

  test "it has found another diagonal win" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"O"]
    row3 = ["X", "8", "9" ]
    board = row1 ++ row2 ++ row3
    assert BoardResult.found_winner?(board) == true
  end

  test "it has found a row win" do
    row1 = ["X", "O", "X"]
    row2 = ["X", "X" ,"X"]
    row3 = ["O", "X", "O" ]
    board = row1 ++ row2 ++ row3
    assert BoardResult.found_winner?(board) == true
  end

  test "it has found a column win" do
    row1 = ["O", "X", "O"]
    row2 = ["O", "X" ,"X"]
    row3 = ["X", "X", "O"]
    board = [row1, row2, row3]
    assert BoardResult.found_winner?(board) == true
  end

  test "X is the winner" do
    row1 = ["O", "X", "O"]
    row2 = ["O", "X" ,"X"]
    row3 = ["X", "X", "O"]
    board = row1 ++ row2 ++ row3
    assert BoardResult.winning_mark(board) == "X"
  end
end

