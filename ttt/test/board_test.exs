defmodule BoardTest do
  use ExUnit.Case
  doctest TTT

  test "it returns an empty 3x3 board" do
    dimension = 3
    expected_board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert TTT.Board.empty_board(dimension) == expected_board
  end

  test "it sets an X mark in a position" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    next_move = 2
    next_mark = "X"
    expected_board = [1, "X", 3, 4, 5, 6, 7, 8, 9]
    assert TTT.Board.play_move(board, next_move, next_mark) == expected_board
  end

  test "it knows the first player's mark" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = [row1, row2, row3]
    marks = ["X", "O"]
    assert TTT.Board.next_mark_to_play(board, marks) == "X"
  end

  test "it knows the next player's mark" do
    row1 = ["X", 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = [row1, row2, row3]
    marks = ["X", "O"]
    assert TTT.Board.next_mark_to_play(board, marks) == "O"
  end

  test "game is over if no more positions remaining" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"X"]
    row3 = ["O", "X", "O"]
    board = [row1, row2, row3]
    marks = ["X", "O"]
    assert TTT.Board.game_over?(board, marks) == true
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
    board = [row1, row2, row3]
    assert TTT.Board.found_winner?(board) == true
  end

  test "it has found a row win" do
    row1 = ["X", "O", "X"]
    row2 = ["X", "X" ,"X"]
    row3 = ["O", "X", "O" ]
    board = [row1, row2, row3]
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
    board = [row1, row2, row3]
    assert TTT.Board.winning_mark(board) == "X"
  end
end
