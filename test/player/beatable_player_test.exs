defmodule BeatablePlayerTest do
  use ExUnit.Case
  alias TTT.Console.Console
  alias TTT.Player.BeatablePlayer

  test "get next move from display" do
    next_move = 8
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"X"]
    row3 = ["O", 8, "O"]
    board = row1 ++ row2 ++ row3
    assert BeatablePlayer.next_move(board, Console) == next_move
  end
end
