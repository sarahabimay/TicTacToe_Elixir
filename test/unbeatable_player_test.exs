defmodule UnbeatablePlayerTest do
  use ExUnit.Case
  doctest TTT

  alias TTT.Console

  test "chooses first available winning move" do
    next_move = 4
    row1 = ["X", "O", "O"]
    row2 = [4, "X" ,"X"]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert TTT.UnbeatablePlayer.next_move("O", board, Console) == next_move
  end

  test "chooses blocking move" do
    next_move = 4
    row1 = [1, 2, "O"]
    row2 = [4, "X" ,"X"]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert TTT.UnbeatablePlayer.next_move("O", board, Console) == next_move
  end

  test "move on a 3x3 board with 1 occupied space" do
    next_move = 5
    row1 = ["X", 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    assert TTT.UnbeatablePlayer.next_move("O", board, Console) == next_move
  end

  test "choose blocking move on 4x4 board" do
    next_move = 10
    row1 = ["O", "X", "X", "O"]
    row2 = ["X", "X", "O", "O"]
    row3 = ["O", 10, "X", "X"]
    row4 = [13, 14, "O", "X"]
    board = row1 ++ row2 ++ row3 ++ row4
    assert TTT.UnbeatablePlayer.next_move("O", board, Console) == next_move
  end

  test "chooses move on 4x4 board with 3 places occupied" do
    next_move = 6
    row1 = ["O", "X", "X", "O"]
    row2 = ["X",  6,  7,  8]
    row3 = [9, 10, 11, 12]
    row4 = [13,14, 15, 16]
    board = row1 ++ row2 ++ row3 ++ row4
    assert TTT.UnbeatablePlayer.next_move("O", board, Console) == next_move
  end
end
