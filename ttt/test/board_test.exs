defmodule BoardTest do
  use ExUnit.Case
  doctest TTT

  test "it returns an empty 3x3 board" do
    dimension = 3
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    expected_board = [row1, row2, row3]
    assert TTT.Board.empty_board(dimension) == expected_board
  end

  test "it sets an X mark in a position" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    next_move = 8
    new_row3 = [7, "X", 9]
    next_mark = "X"
    expected_board = row1 ++ row2 ++ new_row3
    assert TTT.Board.play_move(board, next_move, next_mark) == expected_board
  end

  test "detects an invalid move" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    next_move = "0"
    assert TTT.Board.validate_move(board, next_move) == :invalid
  end

  test "it knows the first player's mark" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert TTT.Board.next_mark_to_play(board) == "X"
  end

  test "it knows the next player's mark" do
    row1 = ["X", 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert TTT.Board.next_mark_to_play(board) == "O"
  end

  test "game is over if no positions remain" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"X"]
    row3 = ["O", "X", "O"]
    board = row1 ++ row2 ++ row3
    assert TTT.Board.game_over?(board) == true
  end

  test "game is over when there is a win" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"O"]
    row3 = [7, 8, "X" ]
    board = [row1, row2, row3]
    assert TTT.Board.game_over?(board) == true
  end

  test "it has a diagonal win" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"O"]
    row3 = ["7", "8", "X" ]
    board = [row1, row2, row3]
    assert TTT.Board.found_winner?(board) == true
  end

  test "it has found another diagonal win" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"O"]
    row3 = ["X", "8", "9" ]
    board = row1 ++ row2 ++ row3
    assert TTT.Board.found_winner?(board) == true
  end

  test "it has found a row win" do
    row1 = ["X", "O", "X"]
    row2 = ["X", "X" ,"X"]
    row3 = ["O", "X", "O" ]
    board = row1 ++ row2 ++ row3
    assert TTT.Board.found_winner?(board) == true
  end

  test "it has found a column win" do
    row1 = ["O", "X", "O"]
    row2 = ["O", "X" ,"X"]
    row3 = ["X", "X", "O"]
    board = [row1, row2, row3]
    assert TTT.Board.found_winner?(board) == true
  end

  test "X is the winner" do
    row1 = ["O", "X", "O"]
    row2 = ["O", "X" ,"X"]
    row3 = ["X", "X", "O"]
    board = row1 ++ row2 ++ row3
    assert TTT.Board.winning_mark(board) == "X"
  end
end
