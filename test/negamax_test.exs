defmodule NegamaxTest do
  use ExUnit.Case
  doctest TTT
  alias TTT.Negamax
  alias TTT.Board

  @initial_alpha -1000000
  @initial_beta 1000000

  test "chooses last move" do
    next_move = 7
    row1 = ["O", "O", "X"]
    row2 = ["X", "X" ,"O"]
    row3 = [7, "X", 9]
    board = row1 ++ row2 ++ row3
    assert Negamax.negamax(remaining_spaces(board), board, @initial_alpha, @initial_beta)[:best_move] == next_move
  end

  test "chooses a blocking move" do
    next_move = 4
    row1 = ["X", "O", "O"]
    row2 = [4, "X" ,"X"]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert Negamax.negamax(remaining_spaces(board), board, @initial_alpha, @initial_beta)[:best_move] == next_move
  end

  test "chooses blocking move" do
    next_move = 5
    row1 = ["X", "O",  3]
    row2 = [ 4,   5,   6]
    row3 = ["O", "X", "X"]
    board = row1 ++ row2 ++ row3
    assert Negamax.negamax(remaining_spaces(board), board, @initial_alpha, @initial_beta)[:best_move] == next_move
  end

  test "move on a 3x3 board with 1 occupied space" do
    next_move = 5
    row1 = ["X", 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert Negamax.negamax(remaining_spaces(board), board, @initial_alpha, @initial_beta)[:best_move] == next_move
  end

  test "choose blocking move on 4x4 board" do
    next_move = 13
    row1 = ["O", "X", "X", "O"]
    row2 = ["X", "X", "O", "O"]
    row3 = ["O", "O", "X", "X"]
    row4 = [13,  14,  "O", "X"]
    board = row1 ++ row2 ++ row3 ++ row4
    assert Negamax.negamax(remaining_spaces(board), board, @initial_alpha, @initial_beta)[:best_move] == next_move
  end

  test "chooses move on 4x4 board with 3 places occupied" do
    next_move = 6
    row1 = [ "O", "X", "X", "O"]
    row2 = [ "X",  6,   7,   8]
    row3 = [  9,  10,  11,  12]
    row4 = [ 13,  14,  "O", 16]
    board = row1 ++ row2 ++ row3 ++ row4
    assert Negamax.negamax(remaining_spaces(board), board, @initial_alpha, @initial_beta)[:best_move] == next_move
  end

  defp remaining_spaces(board) do
    Enum.count(Board.available_positions(board))
  end
end
