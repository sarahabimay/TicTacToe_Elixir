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
    assert TTT.Board.next_mark_to_play(List.flatten(board), marks) == "X"
  end

  test "it knows the next player's mark" do
    row1 = ["X", 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = [row1, row2, row3]
    marks = ["X", "O"]
    assert TTT.Board.next_mark_to_play(List.flatten(board), marks) == "O"
  end

  test "game is over if no more positions remaining" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"X"]
    row3 = ["O", "X", "O"]
    board = [row1, row2, row3]
    marks = ["X", "O"]
    assert TTT.Board.game_over?(List.flatten(board), marks) == true
  end

  test "diagonal values are pulled out of board" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"O"]
    row3 = ["X", "8", "9" ]
    board = [row1, row2, row3]
    diag1 = ["X", "X", "9"]
    diag2 = ["X", "X", "X"]
    assert TTT.Board.diagonal_marks(board) == diag1 ++ diag2
  end

  test "it has a diagonal win" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"O"]
    row3 = ["7", "8", "X" ]
    board = [row1, row2, row3]
    marks = ["X", "O"]
    assert TTT.Board.diagonal_win?(List.flatten(board), marks) == true
  end

  test "it has found a diagonal win" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"O"]
    row3 = ["X", "8", "9" ]
    board = [row1, row2, row3]
    marks = ["X", "O"]
    assert TTT.Board.found_winner?(List.flatten(board), marks) == true
  end

  test "it has found a row win" do
    row1 = ["X", "O", "X"]
    row2 = ["X", "X" ,"X"]
    row3 = ["O", "X", "O" ]
    board = [row1, row2, row3]
    marks = ["X", "O"]
    assert TTT.Board.found_winner?(List.flatten(board), marks) == true
  end
end
