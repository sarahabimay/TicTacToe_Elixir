defmodule ComputerPlayerTest do
  use ExUnit.Case
  doctest TTT

  @display Console

  test "get next move from display" do
    next_move = 8
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"X"]
    row3 = ["O", 8, "O"]
    board = row1 ++ row2 ++ row3
    assert TTT.ComputerPlayer.next_move({board, @display}) == next_move
  end
end
