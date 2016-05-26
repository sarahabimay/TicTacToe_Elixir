defmodule BoardPlayTest do
  use ExUnit.Case
  alias TTT.Board.BoardPlay

  test "it sets an X mark in a position" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    next_move = 8
    new_row3 = [7, "X", 9]
    expected_board = row1 ++ row2 ++ new_row3
    assert BoardPlay.play_move(next_move, board) == expected_board
  end

  test "detects an invalid move" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    next_move = 0
    assert BoardPlay.validate_move(board, next_move) == :invalid
  end

  test "same move cannot be played twice" do
    row1 = ["X", 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    next_move = 1
    assert BoardPlay.validate_move(board, next_move) == :invalid
  end

  test "it knows the first player's mark" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert BoardPlay.next_mark_to_play(board) == "X"
  end

  test "it knows the next player's mark" do
    row1 = ["X", 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert BoardPlay.next_mark_to_play(board) == "O"
  end
end
